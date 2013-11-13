using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Swimomatic;
using Swimomatic.Entity;
using Swimomatic.Manager;
using System.Resources;
using System.Net.Mail;
using System.Configuration;
using System.Security.Cryptography;
using System.Text.RegularExpressions;
using System.Web.Security;
using System.Threading.Tasks;
using System.Collections.Concurrent;


namespace SwimomaticBusinessLib
{
    public class SwimomaticBusinessManager
    {
        #region Enums
        public enum SeedTimeType
        {
            MostRecent = 0,
            SeasonBest = 1,
            PersonalBest = 2
        }
        public enum ScoringEventType
        {
            Heat = 1,
            Final = 2,
            Consolation = 3
        }
        #endregion

        #region Structs
        internal struct AvailableLane
        {
            public int HeatID { get; set; }
            public int HeatNumber { get; set; }
            public int LaneNumber { get; set; }
            public int Seq { get; set; }
        }
        #endregion

        #region Constructors
        public SwimomaticBusinessManager()
        {
        }
        #endregion

        #region Member variables
        private SwimomaticEntityContext entityContext;
        #endregion

        #region Properties
        public SwimomaticEntityContext Ctx
        {
            get
            {
                if (entityContext == null)
                {
                    entityContext = new SwimomaticEntityContext();
                }
                return entityContext;
            }
        }
        #endregion

        #region Public Methods

        public HeatSwimmerCollection GetHeatSwimmersBySwimMeetID(int SwimMeetID)
        {
            return Ctx.HeatSwimmerManager.HeatSwimmerGetAllBySwimMeetID(SwimMeetID);
        }

        public HeatSwimmerCollection GetHeatSwimmersByHeatID(int HeatID)
        {
            return Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatID(HeatID);
        }

        public HeatSheetEvent GetHeatSheetEventByHeatID(int HeatID)
        {
            return Ctx.HeatSheetEventManager.HeatSheetEventGetByHeatID(HeatID);
        }

        public Team GetTeamByHeatSwimmerID(int HeatSwimmerID)
        {
            return Ctx.TeamManager.TeamGetByHeatSwimmerID(HeatSwimmerID);
        }
        #endregion

        #region Private Methods

        public string ReadResourceValue(string resourceFile, string key)
        {
            string resourceValue = string.Empty;
            try
            {
                ResourceManager resourceManager = new ResourceManager("SwimomaticBusinessLib." + resourceFile, GetType().Assembly);
                resourceValue = resourceManager.GetString(key);
            }
            catch (Exception ex)
            {
                resourceValue = string.Empty;
            }
            return resourceValue;
        }

        #endregion

        #region SystemUser Management

        public SystemUser ValidateUser(string UserName, string Password)
        {
            SystemUser su = Ctx.SystemUserManager.SystemUserGetByUserNamePassword(UserName, GetMd5Hash(Password));
            return su;
        }

        public MembershipCreateStatus CreateUser(string City, string Email, string FirstName, string LastName, string Password, int RegionID)
        {
            int newSystemUserID = 0;
            if (SystemUserExists(Email) == MembershipCreateStatus.Success)
            {
                Guid registrationKey = Guid.NewGuid();
                SystemUser su = new SystemUser();
                su.IsActive = false;
                su.RegistrationKey = registrationKey;
                su.FirstName = FirstName;
                su.LastName = LastName;
                su.Email = Email;
                su.City = City;
                su.Password = GetMd5Hash(Password);
                su.RegionID = RegionID;
                su.UserName = Email;
                su.CreateDate = DateTime.Now;
                newSystemUserID = Ctx.SystemUserManager.SystemUserSave(su);

                SendConfirmationEmail(Email, registrationKey);
                return (newSystemUserID > 0) ? MembershipCreateStatus.Success : MembershipCreateStatus.ProviderError;
            }
            else
            {
                return MembershipCreateStatus.DuplicateEmail;
            }
        }

        public void SaveAccountEdit(SystemUser su)
        {
            SystemUser systemUser = Ctx.SystemUserManager.SystemUserGet(su.SystemUserID);
        }

        public SystemUser SavePasswordEdit(SystemUser su)
        {
            SystemUser systemUser = Ctx.SystemUserManager.SystemUserGet(su.SystemUserID);
            if (systemUser.TemporaryPassword.Equals(su.TemporaryPassword))
            {
                systemUser.Password = GetMd5Hash(su.Password);
                systemUser.ModifiedDate = DateTime.Now;
                systemUser.ResetPassword = false;

                //reset registration key so user doesn't accidentally reset again
                systemUser.RegistrationKey = new Guid("00000000-0000-0000-0000-000000000001");
                systemUser.TemporaryPassword = "";

                Ctx.SystemUserManager.SystemUserSave(systemUser);
                return systemUser;
            }
            return su;
        }

        private void SendConfirmationEmail(string Email, Guid registrationKey)
        {
            string EmailBody = ReadResourceValue("Email", "ConfirmationEmailBody");
            string from = ReadResourceValue("Email", "EmailNoReplyFrom");
            string URL = ReadResourceValue("Email", "ConfirmRegistrationURL");
            string subject = "Account Registration";
            string body = string.Format(EmailBody, URL + registrationKey.ToString());
            MailMessage message = new MailMessage(from, Email, subject, body);

            SendEmail(message);
        }

        private void SendEmail(MailMessage message)
        {
            // TODO Get a real SMTP server.
            SmtpClient client = new SmtpClient(ReadResourceValue("Email", "SMTPServer"));
            string credUser = ConfigurationManager.AppSettings["SMTPCredUser"];
            string credKey = ConfigurationManager.AppSettings["SMTPCredKey"];
            System.Net.NetworkCredential cred = new System.Net.NetworkCredential(credUser, credKey);
            client.UseDefaultCredentials = false;
            client.EnableSsl = true;
            client.Credentials = cred;
            client.Port = 587;

            try
            {
                client.SendAsync(message, null);
            }
            catch (Exception ex)
            {
                //      ex.ToString());
            }
        }

        /// <summary>
        /// This method is called when a user posts the link to reset their password.
        /// </summary>
        /// <param name="registrationKey"></param>
        /// <returns></returns>
        public SystemUser ConfirmPasswordReset(Guid registrationKey)
        {
            SystemUser su = Ctx.SystemUserManager.SystemUserGetByRegistrationKey(registrationKey);
            su.ResetPassword = true;
            Ctx.SystemUserManager.SystemUserSave(su);
            return su;
        }

        /// <summary>
        /// This method generates a new Registration Key and temporary password and emails it to the user
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        public SystemUser EmailTemporaryPassword(string UserName)
        {
            SystemUser su = Ctx.SystemUserManager.SystemUserGetByUserName(UserName);
            su.TemporaryPassword = GetRandomlyGeneratedPassword();
            su.RegistrationKey = Guid.NewGuid();
            Ctx.SystemUserManager.SystemUserSave(su);

            string EmailBody = ReadResourceValue("Email", "ResetPasswordEmailBody");
            string from = ReadResourceValue("Email", "EmailNoReplyFrom");
            string URL = ReadResourceValue("Email", "ResetPasswordURL");
            string subject = "Swimomatic Password Reset";
            string body = string.Format(EmailBody, su.TemporaryPassword, URL + su.RegistrationKey.ToString());
            MailMessage message = new MailMessage(from, su.Email, subject, body);
            message.IsBodyHtml = true;

            SendEmail(message);

            return su;
        }

        private string GetRandomlyGeneratedPassword()
        {
            return System.Web.Security.Membership.GeneratePassword(8, 1);
        }

        private MembershipCreateStatus SystemUserExists(string Email)
        {
            SystemUser su = Ctx.SystemUserManager.SystemUserGetByEmail(Email);
            return (su.SystemUserID > 0) ? MembershipCreateStatus.DuplicateEmail : MembershipCreateStatus.Success;
        }

        public SystemUser ConfirmRegistration(Guid registrationKey)
        {
            SystemUser su = Ctx.SystemUserManager.SystemUserGetByRegistrationKey(registrationKey);
            if (su.SystemUserID > 0)
            {
                su.IsActive = true;
                //clear registration key so user doesn't accidentally register again
                su.RegistrationKey = Guid.Empty;
                Ctx.SystemUserManager.SystemUserSave(su);
            }
            return su;
        }


        public string GetMd5Hash(string input)
        {
            // Create a new instance of the MD5CryptoServiceProvider object.
            MD5 md5Hasher = MD5.Create();

            // Convert the input string to a byte array and compute the hash.
            byte[] data = md5Hasher.ComputeHash(Encoding.Default.GetBytes(input));

            // Create a new Stringbuilder to collect the bytes
            // and create a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop through each byte of the hashed data 
            // and format each one as a hexadecimal string.
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            // Return the hexadecimal string.
            return sBuilder.ToString();
        }

        // Verify a hash against a string.
        public bool VerifyMd5Hash(string input, string hash)
        {
            // Hash the input.
            string hashOfInput = GetMd5Hash(input);

            // Create a StringComparer an compare the hashes.
            StringComparer comparer = StringComparer.OrdinalIgnoreCase;

            if (0 == comparer.Compare(hashOfInput, hash))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        #endregion


        public SwimMeet GetSwimMeet(int SwimMeetID)
        {
            return Ctx.SwimMeetManager.SwimMeetGet(SwimMeetID);
        }

        public SwimMeetTeamCollection GetSwimMeetTeamsBySwimMeetID(int SwimMeetID)
        {
            return Ctx.SwimMeetTeamManager.SwimMeetTeamGetAllBySwimMeetID(SwimMeetID);
        }

        public HeatSheetEvent GetHeatSheetEvent(int HeatSheetEventID)
        {
            return Ctx.HeatSheetEventManager.HeatSheetEventGet(HeatSheetEventID);
        }

        public SwimEventCollection GetSwimEvents()
        {
            return Ctx.SwimEventManager.SwimEventGetAll();
        }

        public SwimEvent GetSwimEvent(int SwimEventID)
        {
            return Ctx.SwimEventManager.SwimEventGet(SwimEventID);
        }

        public int SaveHeatSheetEvent(HeatSheetEvent heatSheetEvent)
        {
            heatSheetEvent.HeatSheetEventID = Ctx.HeatSheetEventManager.HeatSheetEventSave(heatSheetEvent);
            return heatSheetEvent.HeatSheetEventID;
        }

        public int SaveHeat(Heat heat)
        {
            return Ctx.HeatManager.HeatSave(heat);
        }

        public AgeClassCollection GetAgeClasses()
        {
            return Ctx.AgeClassManager.AgeClassGetAll();
        }

        public StrokeCollection GetStrokes()
        {
            return Ctx.StrokeManager.StrokeGetAll();
        }

        public SwimEvent GetSwimEventByAgeClassIDStrokeID(int AgeClassID, int StrokeID)
        {
            //if HeatSheetEvent doesn't exist, add it
            SwimEvent swimEvent = Ctx.SwimEventManager.SwimEventGetByAgeClassIDStrokeID(AgeClassID, StrokeID);
            if (swimEvent.SwimEventID == 0)
            {
                swimEvent.AgeClassID = AgeClassID;
                swimEvent.StrokeID = StrokeID;

                Stroke stroke = Ctx.StrokeManager.StrokeGet(StrokeID);
                AgeClass ageClass = Ctx.AgeClassManager.AgeClassGet(AgeClassID);

                swimEvent.Description = ageClass.Description + " " + stroke.Description;
                swimEvent.SwimEventID = Ctx.SwimEventManager.SwimEventSave(swimEvent);
            }
            return swimEvent;
        }

        public bool HeatSheetEventExists(int Distance, int SwimEventID, int HeatSheetID)
        {
            HeatSheetEvent hse = Ctx.HeatSheetEventManager.HeatSheetEventGetByDistanceSwimEventIDHeatSheetID(Distance, HeatSheetID, SwimEventID);
            return (hse.HeatSheetEventID > 0);
        }

        public Pool GetPool(int PoolID)
        {
            return Ctx.PoolManager.PoolGet(PoolID);
        }

        public Location GetLocation(int LocationID)
        {
            return Ctx.LocationManager.LocationGet(LocationID);
        }

        public PoolConfig GetPoolConfig(int PoolConfigID)
        {
            return Ctx.PoolConfigManager.PoolConfigGet(PoolConfigID);
        }

        public UOM GetUOM(int UOMID)
        {
            return Ctx.UOMManager.UOMGet(UOMID);
        }

        public SwimmerCollection GetAvailableSwimmersByHeatID(int HeatID)
        {
            return Ctx.SwimmerManager.SwimmerGetAllAvailableByHeatID(HeatID);
        }

        public void AddHeatSwimmer(int HeatID, int SwimmerTeamSeasonID, int Leg, int LaneNumber)
        {
            //only add the swimmer if a lane is available
            List<int> assignedLaneNumbers = new List<int>();
            HeatSwimmerCollection heatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatID(HeatID);
            heatSwimmers.Sort("LaneNumber", LAAF.Common.Helper.SortDirection.Ascending);
            foreach (HeatSwimmer hs in heatSwimmers)
            {
                assignedLaneNumbers.Add(hs.LaneNumber);
            }

            PoolConfig pc = Ctx.PoolConfigManager.PoolConfigGetByHeatID(HeatID);
            List<int> availableLaneNumbers = new List<int>();
            for (int i = 1; i <= pc.LaneCount; i++)
            {
                if (!assignedLaneNumbers.Contains(i))
                {
                    availableLaneNumbers.Add(i);
                }
            }
            //if a lane is available, or the lane number was explicitly assigned, add the swimmer
            if ((LaneNumber == 0 && availableLaneNumbers.Count > 0) || LaneNumber > 0)
            {
                //Get the SeedResultID, which depends on the SeedTimeType for the SwimMeetTeam
                //TODO: Determine best way to persist SeedTimeType (SwimMeetTeam?, HeatSheetTeam?). For now, default to most recent
                Heat heat = GetHeat(HeatID);
                Result seedResult = GetSeedTime(heat.HeatSheetEventID, SwimmerTeamSeasonID, SwimomaticBusinessLib.SwimomaticBusinessManager.SeedTimeType.MostRecent);

                HeatSwimmer heatSwimmer = new HeatSwimmer();
                heatSwimmer.SeedResultID = seedResult.ResultID;
                heatSwimmer.HeatID = HeatID;
                heatSwimmer.SwimmerTeamSeasonID = SwimmerTeamSeasonID;
                heatSwimmer.Leg = Leg;
                heatSwimmer.LaneNumber = (LaneNumber == 0) ? availableLaneNumbers[0] : LaneNumber; //if lane number is specified, use it.  Otherwise, use the lowest value in the list
                Ctx.HeatSwimmerManager.HeatSwimmerSave(heatSwimmer);
            }

        }

        public Heat GetHeat(int HeatID)
        {
            return Ctx.HeatManager.HeatGet(HeatID);
        }

        public Stroke GetStrokeByHeatID(int HeatID)
        {
            return Ctx.StrokeManager.StrokeGetByHeatID(HeatID);
        }

        public PoolConfig GetPoolConfigByHeatID(int HeatID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetByHeatID(HeatID);
        }

        public void RemoveHeatSwimmer(int HeatSwimmerID)
        {
            Ctx.HeatSwimmerManager.HeatSwimmerDelete(HeatSwimmerID);
        }

        /// <summary>
        /// Increments / Decrements a lane for a swimmer in a non-relay event
        /// </summary>
        /// <param name="HeatID"></param>
        /// <param name="HeatSwimmerID"></param>
        /// <param name="Move"></param>
        public void IncrementHeatSwimmerLane(int HeatID, int HeatSwimmerID, int Move)
        {
            HeatSwimmer heatSwimmer = Ctx.HeatSwimmerManager.HeatSwimmerGet(HeatSwimmerID);
            heatSwimmer.LaneNumber += Move;

            //check to see if any other swimmers are currently in the lane to which the target heatSwimmer is moving to
            //if so, have them switch places with the target heatSwimmer
            HeatSwimmerCollection heatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatID(HeatID);
            heatSwimmers.Sort("LaneNumber", LAAF.Common.Helper.SortDirection.Ascending);
            int newLaneNumber = 0;
            int toBeMovedHeatSwimmerID = 0;
            foreach (HeatSwimmer hs in heatSwimmers)
            {
                if (hs.LaneNumber == heatSwimmer.LaneNumber)
                {
                    newLaneNumber = hs.LaneNumber - Move;
                    toBeMovedHeatSwimmerID = hs.HeatSwimmerID;
                    break;
                }
            }
            //if another heatSwimmer needs to be moved, move them then move the target HeatSwimmer
            if (toBeMovedHeatSwimmerID > 0)
            {
                HeatSwimmer hs = Ctx.HeatSwimmerManager.HeatSwimmerGet(toBeMovedHeatSwimmerID);
                hs.LaneNumber = -1;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs); //have to set lanenumber to -1 to prevent constraint violation
                Ctx.HeatSwimmerManager.HeatSwimmerSave(heatSwimmer);
                hs.LaneNumber = newLaneNumber;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs);
            }
            else //else, just change the lane of the targeted heat swimmer
            {
                Ctx.HeatSwimmerManager.HeatSwimmerSave(heatSwimmer);
            }
        }

        /// <summary>
        /// Increments / Decrements a lane for all swimmers in given lane in a relay event
        /// </summary>
        /// <param name="HeatID"></param>
        /// <param name="HeatSwimmerID"></param>
        /// <param name="Move"></param>
        public void IncrementHeatSwimmerLaneForRelay(int HeatID, int HeatSwimmerID, int Move)
        {
            HeatSwimmer heatSwimmer = Ctx.HeatSwimmerManager.HeatSwimmerGet(HeatSwimmerID);

            //Get the Swimmers that will be moving with the selected swimmer
            HeatSwimmerCollection movingHeatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatIDLaneNumber(HeatID, heatSwimmer.LaneNumber);

            //define the lane where the selected swimmers will be moving
            int oldLaneNumber = heatSwimmer.LaneNumber;
            int newLaneNumber = heatSwimmer.LaneNumber + Move;

            //check to see if any other swimmers are currently in the lane to which the target heatSwimmers are moving to
            HeatSwimmerCollection displacedHeatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatIDLaneNumber(HeatID, newLaneNumber);

            //if there are any displaced heat swimmers, send them to lane -1
            foreach (HeatSwimmer hs in displacedHeatSwimmers)
            {
                hs.LaneNumber = -1;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs);
            }

            //move the target heat swimmers to their new lane
            foreach (HeatSwimmer hs in movingHeatSwimmers)
            {
                hs.LaneNumber = newLaneNumber;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs);
            }

            //finally move the displaced swimmers to the old lane number
            foreach (HeatSwimmer hs in displacedHeatSwimmers)
            {
                hs.LaneNumber = oldLaneNumber;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs);
            }
        }

        public void IncrementHeatSwimmerLeg(int HeatID, int HeatSwimmerID, int Move)
        {
            HeatSwimmer heatSwimmer = Ctx.HeatSwimmerManager.HeatSwimmerGet(HeatSwimmerID);
            heatSwimmer.Leg += Move;
            int laneNumber = heatSwimmer.LaneNumber;

            //check to see if any other swimmers are currently in the leg to which the target heatSwimmer is moving to
            //if so, have them switch places with the target heatSwimmer
            HeatSwimmerCollection heatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatIDLaneNumber(HeatID, laneNumber);
            heatSwimmers.Sort("Leg", LAAF.Common.Helper.SortDirection.Ascending);
            int newLeg = 0;
            int toBeMovedHeatSwimmerID = 0;
            foreach (HeatSwimmer hs in heatSwimmers)
            {
                if (hs.Leg == heatSwimmer.Leg)
                {
                    newLeg = hs.Leg - Move;
                    toBeMovedHeatSwimmerID = hs.HeatSwimmerID;
                    break;
                }
            }
            //if another heatSwimmer needs to be moved, move them then move the target HeatSwimmer
            if (toBeMovedHeatSwimmerID > 0)
            {
                HeatSwimmer hs = Ctx.HeatSwimmerManager.HeatSwimmerGet(toBeMovedHeatSwimmerID);
                hs.Leg = -1;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs); //have to set lanenumber to -1 to prevent constraint violation
                Ctx.HeatSwimmerManager.HeatSwimmerSave(heatSwimmer);
                hs.Leg = newLeg;
                Ctx.HeatSwimmerManager.HeatSwimmerSave(hs);
            }
            else //else, just change the lane of the targeted heat swimmer
            {
                Ctx.HeatSwimmerManager.HeatSwimmerSave(heatSwimmer);
            }
        }

        public void AddHeat(int HeatSheetEventID)
        {
            Heat heat = new Heat();
            heat.HeatNumber = 0;
            heat.HeatSheetEventID = HeatSheetEventID;
            Ctx.HeatManager.HeatSave(heat);
        }

        public Heat GetHeatByHeatSwimmerID(int HeatSwimmerID)
        {
            return Ctx.HeatManager.HeatGetByHeatSwimmerID(HeatSwimmerID);
        }

        /// <summary>
        /// The Heat May only be deleted if there are no results for the Heat
        /// </summary>
        /// <param name="HeatID"></param>
        /// <param name="HeatSheetEventID"></param>
        public void DeleteHeat(int HeatID, int HeatSheetEventID)
        {
            HeatSwimmerCollection heatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatID(HeatID);
            bool resultExists = false;
            foreach (HeatSwimmer heatSwimmer in heatSwimmers)
            {
                resultExists |= ResultExists(heatSwimmer.HeatSwimmerID);
            }
            if (!resultExists)
            {
                Ctx.HeatSwimmerManager.HeatSwimmerDeleteByHeatID(HeatID);
                Ctx.HeatManager.HeatDelete(HeatID);

                //Re-sequence the remaining heats
                ReSequenceHeats(HeatSheetEventID);
            }
        }

        private void ReSequenceHeats(int HeatSheetEventID)
        {
            HeatCollection heats = Ctx.HeatManager.HeatGetAllByHeatSheetEventID(HeatSheetEventID);
            heats.Sort("HeatNumber", LAAF.Common.Helper.SortDirection.Ascending);
            int i = 1;
            foreach (Heat heat in heats)
            {
                if (heat.HeatNumber != i)
                {
                    heat.HeatNumber = i;
                    Ctx.HeatManager.HeatSave(heat);
                }
                i++;
            }
        }

        public void ReSequenceHeatSheetEvents(int HeatSheetID, List<int> HeatSheetEventIDs)
        {
            HeatSheetEventCollection heatSheetEvents = null;
            heatSheetEvents = this.GetHeatSheetEventsByHeatSheetID(HeatSheetID);
            int i = 1;
            foreach (int hseID in HeatSheetEventIDs)
            {
                foreach (HeatSheetEvent heatSheetEvent in heatSheetEvents)
                {
                    if (heatSheetEvent.HeatSheetEventID == hseID)
                    {
                        heatSheetEvent.Sequence = i;
                        this.SaveHeatSheetEvent(heatSheetEvent);
                    }
                }
                i++;
            }
        }

        /// <summary>
        /// Deletes a HeatSheetEvent if there are no results for it
        /// After Deleting the HeatSheetEvent, the remaining HeatSheetEvents are resequenced
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        public void DeleteHeatSheetEvent(int HeatSheetEventID, int HeatSheetID)
        {
            Ctx.BeginTransaction();
            try
            {
                if (DeleteHeatSwimmersByHeatSheetEventID(HeatSheetEventID))
                {
                    Ctx.HeatManager.HeatDeleteByHeatSheetEventID(HeatSheetEventID);
                    Ctx.HeatSheetEventManager.HeatSheetEventDelete(HeatSheetEventID);
                    Ctx.CommitTransaction();

                    //after deleting the HeatSheetEvent, resequence them
                    HeatSheetEventCollection heatSheetEvents = GetHeatSheetEventsByHeatSheetID(HeatSheetID);
                    List<int> heatSheetEventIDs = new List<int>();
                    foreach (HeatSheetEvent sme in heatSheetEvents)
                    {
                        heatSheetEventIDs.Add(sme.HeatSheetEventID);
                    }
                    ReSequenceHeatSheetEvents(HeatSheetID, heatSheetEventIDs);
                }
            }
            catch (Exception ex)
            {
                Ctx.RollbackTransaction();
            }
        }

        public bool ResultExists(int HeatSwimmerID)
        {
            Result result = Ctx.ResultManager.ResultGetByHeatSwimmerID(HeatSwimmerID);
            return (result.ResultID > 0);
        }

        /// <summary>
        /// Delete HeatSwimmers only if there are no results for the HeatSheetEvent
        /// Returns true if HeatSwimmers were deleted, false if they were not deleted
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <returns>bool</returns>
        public bool DeleteHeatSwimmersByHeatSheetEventID(int HeatSheetEventID)
        {
            ResultCollection results = Ctx.ResultManager.ResultGetAllByHeatSheetEventID(HeatSheetEventID);
            foreach (Result result in results)
            {
                if (ResultExists(result.HeatSwimmerID))
                {
                    return false;
                }
            }
            Ctx.HeatSwimmerManager.HeatSwimmerDeleteByHeatSheetEventID(HeatSheetEventID);
            return true;
        }

        /// <summary>
        /// Returns all swimmers in the correct ageClass from all teams involved in a Swim Meet in which the HeatSheetEvent occurs
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <returns></returns>
        public SwimmerCollection GetEligibleSwimmersByHeatSheetEventID(int HeatSheetEventID)
        {
            SwimmerCollection swimmers = Ctx.SwimmerManager.SwimmerGetAllEligibleByHeatSheetEventID(HeatSheetEventID);
            return swimmers;
        }

        public UserTeamCollection GetUserTeamsBySystemUserID(int SystemUserID)
        {
            return Ctx.UserTeamManager.UserTeamGetAllBySystemUserID(SystemUserID);
        }

        public UserLeagueCollection GetUserLeaguesBySystemUserID(int SystemUserID)
        {
            return Ctx.UserLeagueManager.UserLeagueGetAllBySystemUserID(SystemUserID);
        }

        public UserSwimmerCollection GetUserSwimmersBySystemUserID(int SystemUserID)
        {
            return Ctx.UserSwimmerManager.UserSwimmerGetAllBySystemUserID(SystemUserID);
        }
        public UserSwimMeetCollection GetUserSwimMeetsBySystemUserID(int SystemUserID)
        {
            return Ctx.UserSwimMeetManager.UserSwimMeetGetAllBySystemUserID(SystemUserID);
        }

        public League GetLeague(int LeagueID)
        {
            return Ctx.LeagueManager.LeagueGet(LeagueID);
        }

        public Swimmer GetSwimmer(int SwimmerID)
        {
            return Ctx.SwimmerManager.SwimmerGet(SwimmerID);
        }

        public Team GetTeam(int TeamID)
        {
            return Ctx.TeamManager.TeamGet(TeamID);
        }

        public TeamSeasonCollection GetTeamSeasonsByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.TeamSeasonManager.TeamSeasonGetAllByHeatSheetEventID(HeatSheetEventID);
        }

        public SwimmerTeamSeasonCollection GetSwimmerTeamSeasonsBySwimmerID(int SwimmerID)
        {
            return Ctx.SwimmerTeamSeasonManager.SwimmerTeamSeasonGetAllBySwimmerID(SwimmerID);
        }

        /// <summary>
        /// Gets the list of swimmers that are members of the teams participating in the Meet
        /// and have not already been assigned to the HeatSheetEvent
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <returns></returns>
        public SwimmerCollection GetAvailableSwimmersByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.SwimmerManager.SwimmerGetAllAvailableByHeatSheetEventID(HeatSheetEventID);
        }

        public SwimMeet GetSwimMeetByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.SwimMeetManager.SwimMeetGetByHeatSheetEventID(HeatSheetEventID);
        }

        /// <summary>
        /// returns the age at the time of the target date
        /// </summary>
        /// <param name="BirthDate"></param>
        /// <param name="TargetDate"></param>
        /// <returns></returns>
        public int GetAgeAtDate(DateTime BirthDate, DateTime TargetDate)
        {
            int age = TargetDate.Year - BirthDate.Year;
            if (TargetDate.Month < BirthDate.Month || (TargetDate.Month == BirthDate.Month && TargetDate.Day < BirthDate.Day))
            {
                age -= 1;
            }
            return age;
        }

        /// <summary>
        /// Returns Result containing the unadjusted seedtime for the Swimmer in the given HeatSheetEvent for the specified SeedTimeType
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <param name="SeedTimeType"></param>
        /// <returns></returns>
        public Result GetSeedTime(int HeatSheetEventID, int SwimmerTeamSeasonID, SeedTimeType SeedTimeType)
        {
            Result returnResult = new Result();
            SwimmerTeamSeason sts = Ctx.SwimmerTeamSeasonManager.SwimmerTeamSeasonGet(SwimmerTeamSeasonID);
            ResultCollection results = Ctx.ResultManager.ResultGetAllByHeatSheetEventIDSwimmerID(HeatSheetEventID, sts.SwimmerID); //Returns all results for this swimmer, for the stroke & distance in the given HSE
            if (results.Count > 0)
            {
                switch (SeedTimeType)
                {
                    case SeedTimeType.MostRecent:
                        results.Sort("EventDate", LAAF.Common.Helper.SortDirection.Descending);
                        returnResult = results[0];
                        break;
                    case SeedTimeType.SeasonBest:
                        Season s = Ctx.SeasonManager.SeasonGetByHeatSheetEventID(HeatSheetEventID);
                        IEnumerable<Result> sortedResults = from r in results where r.EventDate > s.StartDate orderby r.ElapsedTime ascending select r;
                        if (sortedResults.Count() > 0)
                        {
                            returnResult = ((Result)sortedResults.First());
                        }
                        break;
                    case SeedTimeType.PersonalBest:
                        results.Sort("ElapsedTime", LAAF.Common.Helper.SortDirection.Ascending);
                        returnResult = results[0];
                        break;
                    default:
                        break;
                }
            }
            //if no results are returned, return an empty result with the Swimmer's ID
            else
            {
                returnResult.SwimmerTeamSeasonID = sts.SwimmerTeamSeasonID;
                returnResult.ElapsedTime = 0D;
            }

            return returnResult;
        }

        public double GetConvertedTime(double LaneLength1, int UOMID1, double ElapsedTime, double LaneLength2, int UOMID2)
        {
            double convertedTime = ElapsedTime;
            double conversionFactor = 1.0D;

            if (LaneLength1 == 0D)
            {
                return 0D;
            }

            double lengthRatio = (double)LaneLength2 / (double)LaneLength1;

            switch (UOMID1)
            {
                case 1: //Meters
                    switch (UOMID2)
                    {
                        case 2:
                            conversionFactor = 0.9144D; //Meters to yards
                            break;
                        case 3:
                            conversionFactor = 0.01D; //Meters to Centimeters
                            break;
                        case 4:
                            conversionFactor = 0.0254D; //Meters to Inches
                            break;
                    }
                    break;
                case 2:
                    switch (UOMID2)
                    {
                        case 1:
                            conversionFactor = 1.0936133D; //Yards to Meters
                            break;
                        case 3:
                            conversionFactor = 0.010936133D; //Yards to Centimeters
                            break;
                        case 4:
                            conversionFactor = 0.0277777778D; //Yards to Inches
                            break;
                    }
                    break;
                case 3:
                    switch (UOMID2)
                    {
                        case 1:
                            conversionFactor = 100.0D; //Centimeters to Meters
                            break;
                        case 2:
                            conversionFactor = 91.44D; //Centimeters to Yards
                            break;
                        case 4:
                            conversionFactor = 2.54D; //Centimeters to Inches
                            break;
                    }
                    break;
                case 4:
                    switch (UOMID2)
                    {
                        case 1:
                            conversionFactor = 39.3700787D; //Inches to Meters
                            break;
                        case 2:
                            conversionFactor = 36.0D; //Inches to Yards
                            break;
                        case 3:
                            conversionFactor = 0.393700787D; //Inches to Centimeters
                            break;
                    }
                    break;
            }
            convertedTime = conversionFactor * lengthRatio * ElapsedTime;
            return convertedTime;
        }

        public RegionCollection GetRegions()
        {
            return Ctx.RegionManager.RegionGetAll();
        }

        public AgeClassRuleCollection GetAgeClassRules()
        {
            return Ctx.AgeClassRuleManager.AgeClassRuleGetAll();
        }

        public LocationCollection GetLocationsBySystemUserID(int SystemUserID)
        {
            return Ctx.LocationManager.LocationGetAllBySystemUserID(SystemUserID);
        }

        public PoolConfigCollection GetPoolConfigsByLocationIDList(List<int> locationIDs)
        {
            string sLocationIDs = Utility.ConvertIntListToDelimitedString(locationIDs);
            return Ctx.PoolConfigManager.PoolConfigGetAllByLocationIDList(sLocationIDs);
        }

        public LocationCollection GetLocationsByRegionID(int RegionID)
        {
            return Ctx.LocationManager.LocationGetAllByRegionID(RegionID);
        }

        public LocationCollection GetLocationsByCityRegionID(string City, int RegionID)
        {
            if (City.Equals("0") || City.Equals("-1"))
            {
                return Ctx.LocationManager.LocationGetAllByRegionID(RegionID);
            }
            else
            {
                return Ctx.LocationManager.LocationGetAllByCityRegionID(City, RegionID);
            }
        }

        /// <summary>
        /// Returns the union of Leagues:
        /// 1. where SystemUser has UserLeague records
        /// 2. in a current or future TeamSeason with teams where User is Admin
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public LeagueCollection GetEligibleLeaguesBySystemUserID(int SystemUserID)
        {
            LeagueCollection leagues = GetLeaguesBySystemUserID(SystemUserID);
            LeagueCollection tsLeagues = GetCurrentSeasonLeaguesBySystemUserID(SystemUserID);

            return LAAF.Common.Helper.Union(leagues, tsLeagues, "LeagueID");
        }


        /// <summary>
        /// Returns Leagues that are in a current or future TeamSeason record having teams where User has UserTeam records
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public LeagueCollection GetCurrentSeasonLeaguesBySystemUserID(int SystemUserID)
        {
            return Ctx.LeagueManager.LeagueGetAllCurrentSeasonBySystemUserID(SystemUserID);
        }

        /// <summary>
        /// Returns Leagues where user has UserLeague records
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public LeagueCollection GetLeaguesBySystemUserID(int SystemUserID)
        {
            return Ctx.LeagueManager.LeagueGetAllBySystemUserID(SystemUserID);
        }

        /// <summary>
        /// Returns all the teams with a current or future TeamSeason record containing the given LeagueID
        /// </summary>
        /// <param name="LeagueID"></param>
        /// <returns></returns>
        public TeamCollection GetEligibleTeamsByLeagueID(int LeagueID)
        {
            return Ctx.TeamManager.TeamGetAllCurrentSeasonByLeagueID(LeagueID);
        }

        public HeatSheet GetHeatSheet(int HeatSheetID)
        {
            return Ctx.HeatSheetManager.HeatSheetGet(HeatSheetID);
        }

        public PoolConfig GetPoolConfigByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetByHeatSheetEventID(HeatSheetEventID);
        }

        public PoolConfig GetPoolConfigByHeatSheetID(int HeatSheetID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetByHeatSheetID(HeatSheetID);
        }

        public Pool GetPoolByPoolConfigID(int PoolConfigID)
        {
            return Ctx.PoolManager.PoolGetByPoolConfigID(PoolConfigID);
        }

        public HeatSheetEventCollection GetHeatSheetEventsByHeatSheetID(int HeatSheetID)
        {
            return Ctx.HeatSheetEventManager.HeatSheetEventGetAllByHeatSheetID(HeatSheetID);
        }

        public HeatSheetEventCollection GetHeatSheetEventsByHeatSheetIDSystemUserID(int HeatSheetID, int SystemUserID)
        {
            return Ctx.HeatSheetEventManager.HeatSheetEventGetAllByHeatSheetIDSystemUserID(HeatSheetID, SystemUserID);
        }

        public HeatCollection GetHeatsByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.HeatManager.HeatGetAllByHeatSheetEventID(HeatSheetEventID);
        }

        /// <summary>
        /// Returns all Heats, including HeatSwimmers for a HeatSheet
        /// </summary>
        /// <param name="HeatSheetID"></param>
        /// <returns></returns>
        public HeatSwimmerCollection GetHeatSwimmersByHeatSheetID(int HeatSheetID)
        {
            return Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatSheetID(HeatSheetID);
        }
        /// <summary>
        /// Returns current or future Seasons for the given LeagueID
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public List<Season> GetCurrentSeasonsByLeagueID(int LeagueID)
        {
            return Ctx.SeasonManager.SeasonGetAllCurrentByLeagueID(LeagueID);
        }

        /// <summary>
        /// Returns Teams with a TeamSeasonID containing the SeasonID
        /// </summary>
        /// <param name="SeasonID"></param>
        /// <returns></returns>
        public TeamCollection GetTeamsBySeasonID(int SeasonID)
        {
            return Ctx.TeamManager.TeamGetAllBySeasonID(SeasonID);
        }

        public int SaveSwimMeet(SwimMeet swimMeet, int SystemUserID)
        {

            bool isNew = (swimMeet.SwimMeetID == 0);
            int swimMeetID = Ctx.SwimMeetManager.SwimMeetSave(swimMeet);

            //if this is a new swimMeet, create userteam record for the user that created the meeet
            if (isNew)
            {
                //create a UserSwimMeet for each Team Admin on the Teams involved in the meet
                SwimMeetTeamCollection swimMeetTeams = Ctx.SwimMeetTeamManager.SwimMeetTeamGetAllBySwimMeetID(swimMeetID);
                foreach (SwimMeetTeam smt in swimMeetTeams)
                {
                    UserTeamCollection uts = Ctx.UserTeamManager.UserTeamGetAllByTeamSeasonID(smt.TeamSeasonID);
                    foreach (UserTeam ut in uts)
                    {
                        UserSwimMeet usm = new UserSwimMeet();
                        usm.SystemUserID = ut.SystemUserID;
                        usm.SwimMeetID = swimMeetID;
                        Ctx.UserSwimMeetManager.UserSwimMeetSave(usm);
                    }
                }
            }
            return swimMeetID;
        }

        public int SaveSwimMeetTeam(SwimMeetTeam swimMeetTeam)
        {
            return Ctx.SwimMeetTeamManager.SwimMeetTeamSave(swimMeetTeam);
        }

        public void DeleteSwimMeetTeamsBySwimMeetID(int swimMeetID)
        {
            Ctx.SwimMeetTeamManager.SwimMeetTeamDeleteBySwimMeetID(swimMeetID);
        }

        /// <summary>
        /// Returns all Swim Meet objects for which the SystemUser is the Administrator/Creator
        /// or SystemUser has/had a swimmer participating
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public SwimMeetCollection GetSwimMeetsBySystemUserID(int SystemUserID)
        {
            return Ctx.SwimMeetManager.SwimMeetGetAllBySystemUserID(SystemUserID);
        }

        /// <summary>
        /// Returns all Swim Meet objects for all the Swimmers associated the SystemUser
        /// This will be the Swim Meet history for the User's Swimmer(s)
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public SwimMeetCollection GetSwimMeetsBySystemUserIDAsSwimmerID(int SystemUserID)
        {
            return Ctx.SwimMeetManager.SwimMeetGetAllBySystemUserIDAsSwimmer(SystemUserID);
        }

        public TeamCollection GetTeamsBySwimMeetID(int SwimMeetID)
        {
            return Ctx.TeamManager.TeamGetAllBySwimMeetID(SwimMeetID);
        }

        /// <summary>
        /// Deletes Swim Meet and all children (HeatSwimmer, Heat, HeatSheetEvent, HeatSheet) if there are no results for the SwimMeet
        /// </summary>
        /// <param name="SwimMeetID"></param>
        public void DeleteSwimMeet(int SwimMeetID)
        {
            ResultCollection results = Ctx.ResultManager.ResultGetAllBySwimMeetID(SwimMeetID);
            bool resultsExist = (results.Count > 0);
            if (!resultsExist)
            {
                Ctx.SwimMeetManager.SwimMeetDelete(SwimMeetID);
            }
        }

        public HeatSheetCollection GetHeatSheetsBySwimMeetID(int SwimMeetID)
        {
            return Ctx.HeatSheetManager.HeatSheetGetAllBySwimMeetID(SwimMeetID);
        }

        #region SeedHeatSheetEvent
        public void SeedHeatSheetEvent(int HeatSheetEventID, List<int> SwimmerTeamSeasonIDs)
        {
            //Get Stroke to determine whether it's a relay or not
            Stroke stroke = Ctx.StrokeManager.StrokeGetByHeatSheetEventID(HeatSheetEventID);
            bool IsRelay = stroke.IsRelay;

            //Get dictionary of swimmers grouped by teamSeasonID(Key), swimmer list is sorted by lowest (fastest) seed time first, except swimmers with O seed time are last
            Dictionary<int, List<Result>> teamResults = new Dictionary<int, List<Result>>();
            HeatSheetTeamCollection heatSheetTeams = Ctx.HeatSheetTeamManager.HeatSheetTeamGetAllByHeatSheetEventID(HeatSheetEventID);

            //TODO: Determine How to persist the SeedTimeType (HeatSheetTeam? SwimMeetTeam?) default to most recent for now
            SwimomaticBusinessManager.SeedTimeType seedTimeType = SwimomaticBusinessManager.SeedTimeType.MostRecent;
            if (heatSheetTeams.Count > 0)
            {
                teamResults = GetTeamResults(HeatSheetEventID, SwimmerTeamSeasonIDs, seedTimeType);
            }
            else
            {
                //if there are no HeatSheetTeams, there was a problem creating the heat sheet
                throw new Exception("No Teams have been assigned to the Heat Sheet");
            }

            //Get dictionary of currently Available Lanes grouped by teamID(Key), for any existing heats
            Dictionary<int, List<AvailableLane>> teamAvailableLanes = GetTeamAvailableLanes(HeatSheetEventID, heatSheetTeams);

            //Determine if additional new heats are needed and create them if necessary
            int heatsNeededForThisTeam = 0;
            int totalHeatsNeeded = 0;
            HeatSheetTeam heatSheetTeam = null;
            if (IsRelay) //If the event is an Individual event, the number of needed heats is calculated differently from a relay
            {
                foreach (int TeamSeasonID in teamResults.Keys)
                {
                    //if the number of realy teams (4 swimmers) for this team exceeds the number of available lanes for this team...
                    if (teamResults[TeamSeasonID].Count / 4 > teamAvailableLanes[TeamSeasonID].Count)
                    {
                        heatSheetTeam = (HeatSheetTeam)heatSheetTeams.Where(h => h.TeamSeasonID == TeamSeasonID).First();

                        //heats needed for the current team = number of relay teams (4 swimmers) divided by available lanes, + 1 more if there is any remainder
                        heatsNeededForThisTeam = ((teamResults[TeamSeasonID].Count / 4) % heatSheetTeam.LaneList.Count == 0) ? (teamResults[TeamSeasonID].Count / 4) / heatSheetTeam.LaneList.Count : ((teamResults[TeamSeasonID].Count / 4) / heatSheetTeam.LaneList.Count) + 1;
                    }
                }
            }
            else
            {
                foreach (int TeamSeasonID in teamResults.Keys)
                {
                    //if the number of swimmers for this team exceeds the number of available lanes for this team...
                    if (teamResults[TeamSeasonID].Count > teamAvailableLanes[TeamSeasonID].Count)
                    {
                        heatSheetTeam = (HeatSheetTeam)heatSheetTeams.Where(h => h.TeamSeasonID == TeamSeasonID).First();

                        //heats needed for the current team = number of swimmers divided by available lanes, + 1 more if there is any remainder
                        heatsNeededForThisTeam = (teamResults[TeamSeasonID].Count % heatSheetTeam.LaneList.Count == 0) ? teamResults[TeamSeasonID].Count / heatSheetTeam.LaneList.Count : (teamResults[TeamSeasonID].Count / heatSheetTeam.LaneList.Count) + 1;
                    }
                }
            }
            totalHeatsNeeded = Math.Max(totalHeatsNeeded, heatsNeededForThisTeam);
            Heat ht;
            for (int i = 0; i < totalHeatsNeeded; i++)
            {
                ht = new Heat();
                ht.HeatSheetEventID = HeatSheetEventID;
                Ctx.HeatManager.HeatSave(ht);
            }

            //Finally, assign swimmers to heats

            //first, refresh Available Lanes now that new heats may have been added
            teamAvailableLanes = GetTeamAvailableLanes(HeatSheetEventID, heatSheetTeams);
            List<AvailableLane> availableLanes;
            int j = 0;
            if (IsRelay)
            {
                int leg = 0;
                List<int> swimmerTeamSeasonIDs = new List<int>();
                List<List<int>> relayTeams = null;
                foreach (int TeamID in teamResults.Keys)
                {
                    leg = 0;
                    relayTeams = new List<List<int>>();
                    foreach (Result r in teamResults[TeamID])
                    {
                        swimmerTeamSeasonIDs.Add(r.SwimmerTeamSeasonID);
                        leg++;
                        //add 4 swimmers to each swimmerIDs list then add that list to the relayTeams list
                        //if there are less than an even 4 swimmers at the end of the list, they get left off (input validation should require even groups of 4 for seeding relays)
                        //TODO:input validation should require even groups of 4 swimmers for seeding relays
                        if (leg == 4)
                        {
                            relayTeams.Add(swimmerTeamSeasonIDs);
                            swimmerTeamSeasonIDs = new List<int>();
                            leg = 0;
                        }
                    }
                    availableLanes = teamAvailableLanes[TeamID];
                    j = 0;
                    foreach (List<int> swmrTSIDs in relayTeams)
                    {
                        leg = 1;
                        foreach (int swimmerTeamSeasonID in swmrTSIDs)
                        {
                            if (availableLanes.Count > j)
                            {
                                AddHeatSwimmer(availableLanes[j].HeatID, swimmerTeamSeasonID, leg, availableLanes[j].LaneNumber);
                                leg++;
                            }
                        }
                        j++;
                    }
                }
            }
            else
            {
                foreach (int TeamID in teamResults.Keys)
                {
                    j = 0;
                    availableLanes = teamAvailableLanes[TeamID];
                    foreach (Result r in teamResults[TeamID])
                    {
                        if (availableLanes.Count > j)
                        {
                            AddHeatSwimmer(availableLanes[j].HeatID, r.SwimmerTeamSeasonID, 0, availableLanes[j].LaneNumber);
                            j++;
                        }
                    }
                }
            }
        }

        /// <summary>
        ///  Returns a Dictionary<TeamID,List<AvailableLane>> object containing the available lanes for and event, grouped by team
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <param name="heatSheetTeams"></param>
        /// <returns></returns>
        private Dictionary<int, List<AvailableLane>> GetTeamAvailableLanes(int HeatSheetEventID, HeatSheetTeamCollection heatSheetTeams)
        {
            Dictionary<int, List<AvailableLane>> teamAvailableLanes = new Dictionary<int, List<AvailableLane>>();
            PoolConfig poolConfig = Ctx.PoolConfigManager.PoolConfigGetByHeatSheetEventID(HeatSheetEventID);
            foreach (HeatSheetTeam hst in heatSheetTeams)
            {
                if (!teamAvailableLanes.Keys.Contains(hst.TeamSeasonID))
                {
                    teamAvailableLanes.Add(hst.TeamSeasonID, new List<AvailableLane>());
                }
                ((List<AvailableLane>)teamAvailableLanes[hst.TeamSeasonID]).AddRange(GetAvailableLanes(HeatSheetEventID, hst.LaneList, poolConfig.LaneSequence));
            }

            return teamAvailableLanes;
        }

        /// <summary>
        /// Returns a Dictionary<TeamID,List<Result>> object containing the seed times for the members of a team, grouped by team
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <param name="SwimmerTeamSeasonIDs"></param>
        /// <param name="seedTimeType"></param>
        /// <returns></returns>
        private Dictionary<int, List<Result>> GetTeamResults(int HeatSheetEventID, List<int> SwimmerTeamSeasonIDs, SeedTimeType seedTimeType)
        {
            Dictionary<int, List<Result>> teamResults = new Dictionary<int, List<Result>>();
            //get the SeedTime for each swimmer
            Result result = null;
            foreach (int swimmerTeamSeasonID in SwimmerTeamSeasonIDs)
            {
                SwimmerTeamSeason sts = Ctx.SwimmerTeamSeasonManager.SwimmerTeamSeasonGet(swimmerTeamSeasonID);
                result = GetSeedTime(HeatSheetEventID, swimmerTeamSeasonID, seedTimeType);
                result.ElapsedTime = (result.ElapsedTime > 0) ? result.ElapsedTime : 100000.0D;
                if (!teamResults.Keys.Contains(sts.TeamSeasonID))
                {
                    teamResults.Add(sts.TeamSeasonID, new List<Result>());
                }
                ((List<Result>)teamResults[sts.TeamSeasonID]).Add(result);
            }
            foreach (KeyValuePair<int, List<Result>> item in teamResults)
            {
                item.Value.Sort(delegate(Result s1, Result s2) { return s1.ElapsedTime.CompareTo(s2.ElapsedTime); });
            }
            return teamResults;
        }

        /// <summary>
        /// Returns a list of available lanes for existing heats in the event.
        /// The list of available lanes is filtered by the list of lanes provided 
        /// The list of available lanes is sorted first by fastest heat (higher numbered heats are faster), then by the lane's distance from the center of the pool(the center of the pool is the fastest lane)
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <param name="Lanes"></param>
        /// <returns></returns>
        private List<AvailableLane> GetAvailableLanes(int HeatSheetEventID, List<int> Lanes, Dictionary<int, int> LaneSequence)
        {
            List<AvailableLane> availableLanes = new List<AvailableLane>();
            HeatCollection heats = Ctx.HeatManager.HeatGetAllByHeatSheetEventID(HeatSheetEventID);
            HeatSwimmerCollection heatSwimmers = null;
            bool laneIsAvailable;

            //For each heat in the event...
            foreach (Heat heat in heats)
            {
                //Get the swimmers already assigned to lanes in this heat
                heatSwimmers = Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatID(heat.HeatID);
                heatSwimmers.Sort(delegate(HeatSwimmer hs1, HeatSwimmer hs2) { return hs1.LaneNumber.CompareTo(hs2.LaneNumber); }); //sorted by lane number ascending
                AvailableLane availableLane;

                foreach (int lane in Lanes)
                {
                    laneIsAvailable = true;
                    foreach (HeatSwimmer heatSwimmer in heatSwimmers)
                    {
                        if (heatSwimmer.LaneNumber == lane)
                        {
                            laneIsAvailable = false;
                            break;
                        }
                    }
                    if (laneIsAvailable)
                    {
                        availableLane = new AvailableLane();
                        availableLane.HeatID = heat.HeatID;
                        availableLane.HeatNumber = heat.HeatNumber;
                        availableLane.LaneNumber = lane;
                        availableLane.Seq = LaneSequence[availableLane.LaneNumber];
                        availableLanes.Add(availableLane);
                    }
                }
            }

            List<AvailableLane> returnList = availableLanes.OrderByDescending(a => a.HeatNumber).ThenBy(a => a.Seq).ToList();
            return returnList;
        }
        #endregion

        public int SaveHeatSheet(int PoolConfigID, int SwimMeetID)
        {
            HeatSheet heatSheet = new HeatSheet();
            heatSheet.PoolConfigID = PoolConfigID;
            heatSheet.SwimMeetID = SwimMeetID;
            int heatSheetID = Ctx.HeatSheetManager.HeatSheetSave(heatSheet);
            return heatSheetID;
        }

        public int SaveHeatSheetTeam(HeatSheetTeam heatSheetTeam)
        {
            int heatSheetTeamID = Ctx.HeatSheetTeamManager.HeatSheetTeamSave(heatSheetTeam);
            return heatSheetTeamID;
        }

        public SwimmerCollection GetSwimmersBySystemUserID(int SystemUserID)
        {
            return Ctx.SwimmerManager.SwimmerGetAllBySystemUserID(SystemUserID);
        }

        public int SaveSwimmer(Swimmer Swimmer)
        {
            return Ctx.SwimmerManager.SwimmerSave(Swimmer);
        }

        public int SaveUserSwimmer(int SwimmerID, int SystemUserID)
        {
            UserSwimmer userSwimmer = new UserSwimmer();
            userSwimmer.SwimmerID = SwimmerID;
            userSwimmer.SystemUserID = SystemUserID;
            return Ctx.UserSwimmerManager.UserSwimmerSave(userSwimmer);
        }

        public int SaveUserTeam(int TeamID, int SystemUserID)
        {
            UserTeam userTeam = new UserTeam();
            userTeam.TeamID = TeamID;
            userTeam.SystemUserID = SystemUserID;
            return Ctx.UserTeamManager.UserTeamSave(userTeam);
        }

        public int SaveTeam(Team Team)
        {
            return Ctx.TeamManager.TeamSave(Team);
        }

        public TeamCollection GetTeamsBySystemUserID(int SystemUserID)
        {
            return Ctx.TeamManager.TeamGetAllBySystemUserID(SystemUserID);
        }

        public int SaveLeague(League League)
        {
            return Ctx.LeagueManager.LeagueSave(League);
        }

        public int SaveUserLeague(int LeagueID, int SystemUserID)
        {
            UserLeague userLeague = new UserLeague();
            userLeague.LeagueID = LeagueID;
            userLeague.SystemUserID = SystemUserID;
            return Ctx.UserLeagueManager.UserLeagueSave(userLeague);
        }

        public TeamCollection GetTeamBySearch(string Address, string City, string PostalCode, int RegionID, string TeamName)
        {
            return Ctx.TeamManager.TeamGetAllBySearch(Address, City, PostalCode, RegionID, TeamName);
        }

        public int SaveSwimmerTeamRequest(int TeamSeasonID, int UserSwimmerID)
        {
            int returnValue = 0;
            bool requestPermitted = GetSwimmerTeamRequestIsPermitted(TeamSeasonID, UserSwimmerID);
            if (requestPermitted)
            {
                SwimmerTeamRequest str = new SwimmerTeamRequest();
                str.TeamSeasonID = TeamSeasonID;
                str.UserSwimmerID = UserSwimmerID;
                str.IsApproved = false;
                str.RequestDate = DateTime.Today;
                returnValue = Ctx.SwimmerTeamRequestManager.SwimmerTeamRequestSave(str);
            }
            return returnValue;
        }

        /// <summary>
        /// Returns a boolean indicating whether a Swimmer may be a member of the requested team
        /// A swimmer may only be a member of 1 team that is a member of a Season
        /// i.e, if a swimmer is a member of a team that is in a certain league's season, he can't join another team in the same league during the same season.
        /// </summary>
        /// <param name="TeamSeasonID"></param>
        /// <param name="UserSwimmerID"></param>
        /// <returns></returns>
        private bool GetSwimmerTeamRequestIsPermitted(int TeamSeasonID, int UserSwimmerID)
        {
            int permitted = Ctx.SwimmerTeamRequestManager.SwimmerTeamRequestIsPermitted(TeamSeasonID, UserSwimmerID);
            return (permitted == 1) ? true : false;
        }

        public Swimmer GetSwimmerByUserSwimmerID(int UserSwimmerID)
        {
            UserSwimmer us = Ctx.UserSwimmerManager.UserSwimmerGet(UserSwimmerID);
            return GetSwimmer(us.SwimmerID);
        }

        public SeasonCollection GetSeasonsByTeamID(int TeamID)
        {
            return Ctx.SeasonManager.SeasonGetAllByTeamID(TeamID);
        }

        public SwimmerCollection GetSwimmersByTeamSeasonID(int TeamSeasonID)
        {
            return Ctx.SwimmerManager.SwimmerGetAllByTeamSeasonID(TeamSeasonID);
        }

        /// <summary>
        /// Returns the Team-League requests if the system user is a league Admin
        /// </summary>
        /// <param name="TeamSeasonID"></param>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public SwimmerCollection GetSwimmerTeamRequestsBySystemUserIDTeamSeasonID(int SystemUserID, int TeamSeasonID)
        {
            return Ctx.SwimmerManager.SwimmerTeamRequestGetAllBySystemUserIDTeamSeasonID(SystemUserID, TeamSeasonID);
        }

        public Team GetTeamByUserTeamID(int UserTeamID)
        {
            return Ctx.TeamManager.TeamGetByUserTeamID(UserTeamID);
        }

        public SeasonCollection GetSeasonsBySearch(string LeagueName, int RegionID)
        {
            return Ctx.SeasonManager.SeasonGetAllBySearch(LeagueName, RegionID);
        }

        public int SaveTeamLeagueRequest(int SeasonID, int UserTeamID)
        {
            TeamLeagueRequest tlr = new TeamLeagueRequest();
            tlr.SeasonID = SeasonID;
            tlr.UserTeamID = UserTeamID;
            tlr.IsApproved = false;
            tlr.RequestDate = DateTime.Today;
            int TeamLeagueRequestID = Ctx.TeamLeagueRequestManager.TeamLeagueRequestSave(tlr);
            return TeamLeagueRequestID;
        }

        public SeasonCollection GetSeasonsByLeagueIDSystemUserID(int LeagueID, int SystemUserID)
        {
            return Ctx.SeasonManager.SeasonGetAllByLeagueIDSystemUserID(LeagueID, SystemUserID);
        }

        /// <summary>
        /// Returns TeamLeagueRequests if the SystemUser is a Team adminstartor (has a UserTeam record)
        /// </summary>
        /// <param name="SeasonID"></param>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public TeamCollection GetTeamLeagueRequestsBySeasonIDSystemUserID(int SeasonID, int SystemUserID)
        {
            return Ctx.TeamManager.TeamLeagueRequestGetAllBySeasonIDSystemUserID(SeasonID, SystemUserID);
        }

        /// <summary>
        /// Returns the SwimmerTeamSeasonID created after the Request is approved
        /// </summary>
        /// <param name="SwimmerTeamRequestID"></param>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public int ApproveSwimmerTeamRequest(int SwimmerTeamRequestID, int SystemUserID)
        {
            //update the request to Approved & save audit trail
            SwimmerTeamRequest strq = Ctx.SwimmerTeamRequestManager.SwimmerTeamRequestGet(SwimmerTeamRequestID);
            strq.ApprovalDate = DateTime.Today;
            strq.ApprovalUserID = SystemUserID;
            strq.IsApproved = true;

            Ctx.SwimmerTeamRequestManager.SwimmerTeamRequestSave(strq);

            //Create SwimmerTeamSeason record
            UserSwimmer us = Ctx.UserSwimmerManager.UserSwimmerGet(strq.UserSwimmerID);
            Season s = Ctx.SeasonManager.SeasonGetByTeamSeasonID(strq.TeamSeasonID);

            SwimmerTeamSeason sts = new SwimmerTeamSeason();
            sts.SwimmerID = us.SwimmerID;
            sts.TeamSeasonID = strq.TeamSeasonID;
            sts.StartDate = s.StartDate;
            sts.EndDate = s.EndDate;
            int stsID = Ctx.SwimmerTeamSeasonManager.SwimmerTeamSeasonSave(sts);
            return stsID;
        }

        /// <summary>
        /// Returns the TeamSeasonID created after the Request is approved
        /// </summary>
        /// <param name="TeamLeagueRequestID"></param>
        /// <param name="p"></param>
        public int ApproveTeamLeagueRequest(int TeamLeagueRequestID, int SystemUserID)
        {
            //update the request to Approved & save audit trail
            TeamLeagueRequest tlr = Ctx.TeamLeagueRequestManager.TeamLeagueRequestGet(TeamLeagueRequestID);
            tlr.ApprovalDate = DateTime.Today;
            tlr.ApprovalUserID = SystemUserID;
            tlr.IsApproved = true;

            Ctx.TeamLeagueRequestManager.TeamLeagueRequestSave(tlr);

            //Create TeamSeason record
            UserTeam ut = Ctx.UserTeamManager.UserTeamGet(tlr.UserTeamID);
            League l = Ctx.LeagueManager.LeagueGetBySeasonID(tlr.SeasonID);
            Season s = GetSeason(tlr.SeasonID);

            TeamSeason ts = new TeamSeason();
            ts.SeasonID = tlr.SeasonID;
            ts.TeamID = ut.TeamID;
            ts.LeagueID = l.LeagueID;
            ts.AgeClassRuleID = s.AgeClassRuleID;
            int tsID = Ctx.TeamSeasonManager.TeamSeasonSave(ts);
            return tsID;
        }

        public Team GetTeamByTeamSeasonID(int TeamSeasonID)
        {
            return Ctx.TeamManager.TeamGetByTeamSeasonID(TeamSeasonID);
        }

        public int SaveLocation(Location location, int SystemUserID)
        {
            //audit trail of create/edit
            if (location.LocationID == 0)
            {
                location.CreatedByUserID = SystemUserID;
                location.CreatedDate = DateTime.Now;
            }
            else
            {
                Location l = Ctx.LocationManager.LocationGet(location.LocationID);
                location.ModifiedByUserID = SystemUserID;
                location.ModifiedDate = DateTime.Now;
            }
            return Ctx.LocationManager.LocationSave(location);
        }

        /// <summary>
        /// Returns information for all PoolConfigs assigned to Heat Sheets in the Swim Meet
        /// </summary>
        /// <param name="SwimMeetID"></param>
        /// <returns></returns>
        public PoolConfigCollection GetPoolConfigsBySwimMeetID(int SwimMeetID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetAllBySwimMeetID(SwimMeetID);
        }

        public PoolConfigCollection GetPoolConfigsByLocationID(int LocationID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetAllByLocationID(LocationID);
        }

        public UOMCollection GetUOMs()
        {
            return Ctx.UOMManager.UOMGetAll();
        }

        /// <summary>
        /// Returns the decimal value of the Lane Length given the Meters/Cm or Yards/In
        /// </summary>
        /// <param name="LengthMajor"></param>
        /// <param name="LengthMinor"></param>
        /// <param name="UOMID"></param>
        /// <returns></returns>
        public double GetLaneLength(int LengthMajor, int LengthMinor, int UOMID)
        {
            double length = (double)LengthMajor;
            switch (UOMID)
            {
                case 1: //Meters
                    length += (double)LengthMinor * 0.01D;
                    break;
                case 2: //Yards
                    length += (double)LengthMinor * 0.0277777778D;
                    break;
                default:
                    break;
            }
            return length;
        }

        public int SavePoolConfig(PoolConfig poolConfig, int SystemUserID)
        {
            //audit trail of create/edit
            if (poolConfig.PoolConfigID == 0)
            {
                poolConfig.CreatedByUserID = SystemUserID;
                poolConfig.CreatedDate = DateTime.Now;
            }
            else
            {
                PoolConfig pc = Ctx.PoolConfigManager.PoolConfigGet(poolConfig.PoolConfigID);
                poolConfig.CreatedByUserID = pc.CreatedByUserID;
                poolConfig.CreatedDate = pc.CreatedDate;
                poolConfig.ModifiedByUserID = SystemUserID;
                poolConfig.ModifiedDate = DateTime.Now;
            }
            return Ctx.PoolConfigManager.PoolConfigSave(poolConfig);
        }


        public Location GetLocationBySwimMeetID(int SwimMeetID)
        {
            return Ctx.LocationManager.LocationGetBySwimMeetID(SwimMeetID);
        }

        public int SavePool(Pool pool, int SystemUserID)
        {
            if (pool.PoolID == 0)
            {
                pool.CreatedByUserID = SystemUserID;
                pool.CreatedDate = DateTime.Now;
            }
            else
            {
                pool.ModifiedByUserID = SystemUserID;
                pool.ModifiedDate = DateTime.Now;
            }
            return Ctx.PoolManager.PoolSave(pool);
        }

        #region Results/Scoring
        public Result GetResult(int ResultID)
        {
            return Ctx.ResultManager.ResultGet(ResultID);
        }

        public ScoringSchemeCollection GetUSASwimmingScoringSchemes(bool IsUSASwimming, ScoringEventType sct)
        {
            int ScoringEventTypeID = (int)sct;
            return Ctx.ScoringSchemeManager.ScoringSchemeGetAllByUSASwimmingScoringEventTypeID(IsUSASwimming, ScoringEventTypeID);
        }

        public Season GetSeason(int SeasonID)
        {
            return Ctx.SeasonManager.SeasonGet(SeasonID);
        }

        public ScoringSchemeCollection GetScoringSchemesBySeasonID(int SeasonID)
        {
            return Ctx.ScoringSchemeManager.ScoringSchemeGetAllBySeasonID(SeasonID);
        }

        public int SaveSeason(Season season)
        {
            return Ctx.SeasonManager.SeasonSave(season);
        }

        public void DeleteSeasonScoringSchemesBySeasonID(int SeasonID)
        {
            Ctx.SeasonScoringSchemeManager.SeasonScoringSchemeDeleteBySeasonID(SeasonID);
        }

        public int SaveSeasonScoringScheme(SeasonScoringScheme seasonScoringScheme)
        {
            return Ctx.SeasonScoringSchemeManager.SeasonScoringSchemeSave(seasonScoringScheme);
        }
        /// <summary>
        /// Saves a list of results for Individual and Relay Events.  NOTE: all results in the list should be from the same HeatSheetEvent
        /// </summary>
        /// <param name="results"></param>
        public void SaveResults(int HeatSheetEventID, List<Result> results, int SystemUserID)
        {
            if (results.Count > 0)
            {
                List<Result> saveResults = new List<Result>(); //this list will merge existing results with new results
                ResultCollection existingResults = Ctx.ResultManager.ResultGetAllByHeatSheetEventID(HeatSheetEventID);

                //merge lists
                foreach (Result result in results)
                {
                    //if there's not an object already in the saveResults, 
                    //create a new one & add it to the list, 
                    //else update the values
                    var saveResult = saveResults.Where(r => r.HeatSwimmerID == result.HeatSwimmerID).FirstOrDefault();
                    if (saveResult == null)
                    {
                        saveResult = new Result();
                        saveResult.HeatSwimmerID = result.HeatSwimmerID;
                        saveResult.CreatedByUserID = SystemUserID;
                        saveResult.CreatedDate = DateTime.Now;
                        saveResult.Disqualified = result.Disqualified;
                        saveResult.ElapsedTime = result.ElapsedTime;
                        saveResult.Split = result.Split;
                        saveResults.Add(saveResult);
                    }
                    else
                    {
                        saveResult.ModifiedByUserID = SystemUserID;
                        saveResult.ModifiedDate = DateTime.Now;
                        saveResult.Disqualified = result.Disqualified;
                        saveResult.ElapsedTime = result.ElapsedTime;
                        saveResult.Split = result.Split;
                    }
                }
                //finally save the results to the DB
                foreach (Result saveResult in saveResults)
                {
                    Ctx.ResultManager.ResultSave(saveResult);
                }

                //Get Scoring Scheme
                ///TODO:This logic is going to have to change to accomodate more complex scoring scheme scenarios.  For now, use the first one returned                
                ScoringSchemeCollection scoringSchemes = Ctx.ScoringSchemeManager.ScoringSchemeGetAllByHeatSheetEventID(HeatSheetEventID);
                ScoringScheme scoringScheme = scoringSchemes.Where(ss => ss.SwimMeetTypeID == 1).FirstOrDefault();
                SetResultScores(HeatSheetEventID, scoringScheme.ScoringSchemeID);
            }
        }

        /// <summary>
        /// Saves custom Scoring Schemes.  
        /// All USA Swimming Scoring Schemes will be maintained internally and cannot be changed by the user
        /// If an identical Scoring Scheme exists, a new one won't be created.
        /// </summary>
        /// <param name="IsRelay"></param>
        /// <param name="Points"></param>
        /// <returns></returns>
        public int SaveScoringScheme(ScoringScheme scoringScheme)
        {
            //
            scoringScheme.Description = "Custom: Ind-" + scoringScheme.IndividualPoints + " Rly-" + scoringScheme.RelayPoints;
            scoringScheme.IsUSASwimming = false;
            scoringScheme.LaneCount = 0;
            scoringScheme.ScoringSchemeID = 0; //always use 0 because changes must be saved to a new scoring Scheme record.
            scoringScheme.ScoringEventTypeID = 1; //TODO: use ScoringEventTypeID = 1 until Events can be designated as Heat, Final or Consolation
            return Ctx.ScoringSchemeManager.ScoringSchemeSave(scoringScheme);
        }

        /// <summary>
        /// Apply scoring to results
        /// </summary>
        /// <param name="HeatSheetEventID"></param>
        /// <param name="ScoringSchemeID"></param>
        private void SetResultScores(int HeatSheetEventID, int ScoringSchemeID)
        {
            //Get Stroke to determine whether it's a relay or not
            Stroke stroke = Ctx.StrokeManager.StrokeGetByHeatSheetEventID(HeatSheetEventID);

            //Get results
            ResultCollection results = Ctx.ResultManager.ResultGetAllByHeatSheetEventID(HeatSheetEventID);
            List<Result> sortedResults = (from r in results where !r.Disqualified orderby r.ElapsedTime ascending, r.LaneNumber select r).ToList();

            //Get Scoring Scheme
            ScoringScheme scoringScheme = Ctx.ScoringSchemeManager.ScoringSchemeGet(ScoringSchemeID);

            //Get a list of the count of individuals or relay teams that finished in each place (place is a zero based ordinal, 0=1st, 1=2nd)
            List<int> placeFinishers = GetPlaceFinishers(sortedResults, scoringScheme.RelayPointsList.Count, stroke.IsRelay);

            int place = 0;
            double pointsPerPlace = 0.0;
            int finishersPerPlace = 0;
            double pointsPerFinisher = 0.0;
            if (stroke.IsRelay)
            {
                //Get a dictionary with a sequence of relay teams, ordered by elapsed time
                Dictionary<int, List<int>> teamHeatSwimmerIDs = GetTeamHeatSwimmersIDs(sortedResults);

                //apply points and save results
                Result sortedResult;
                List<int> heatSwimmerIDs = null;

                //for each place
                for (place = 0; place < placeFinishers.Count; place++)
                {
                    //get the number of finishers for the current place,  i.e., if there is a 3 way tie for 1st, there will be 3 finishers
                    finishersPerPlace = placeFinishers[place];

                    //get the points per Place --points that will be split among each swimmer in a given place i.e., if there is a tie for 1st, etc.
                    pointsPerPlace = scoringScheme.GetPointsPerPlace(place, finishersPerPlace, true);

                    //divide the number of points per place by finishers per place to determine the number of points each swimmer sshould get
                    pointsPerFinisher = pointsPerPlace / finishersPerPlace;

                    for (int j = place; j < place + finishersPerPlace; j++)
                    {
                        heatSwimmerIDs = teamHeatSwimmerIDs[j];
                        foreach (int heatSwimmerID in heatSwimmerIDs)
                        {
                            sortedResult = sortedResults.Where(sr => sr.HeatSwimmerID == heatSwimmerID).SingleOrDefault();
                            sortedResult.Points = pointsPerFinisher;
                            sortedResult.Place = place + 1; //add 1 because place is zero-indexed
                            sortedResult.ScoringSchemeID = ScoringSchemeID;
                            Ctx.ResultManager.ResultSave(sortedResult);
                        }
                    }
                }
            }
            else
            {
                //for each place
                for (place = 0; place < placeFinishers.Count; place++)
                {
                    //get the number of finishers for the current place,  i.e., if there is a 3 way tie for 1st, there will be 3 finishers
                    finishersPerPlace = placeFinishers[place];

                    //get the points per Place --points that will be split among each swimmer in a given place i.e., if there is a tie for 1st, etc.
                    pointsPerPlace = scoringScheme.GetPointsPerPlace(place, finishersPerPlace, false);

                    //divide the number of points per place by finishers per place to determine the number of points each swimmer sshould get
                    pointsPerFinisher = pointsPerPlace / finishersPerPlace;

                    for (int j = place; j < place + finishersPerPlace; j++)
                    {
                        sortedResults[j].Points = pointsPerFinisher;
                        sortedResults[j].Place = place + 1; //add 1 because place is zero-indexed
                        sortedResults[j].ScoringSchemeID = ScoringSchemeID;
                        Ctx.ResultManager.ResultSave(sortedResults[j]);
                    }
                }
            }
        }

        /// <summary>
        /// Returns a dictionary containing the HeatSwimmerIDs of relay team members, sorted by their finishing sequence
        /// </summary>
        /// <param name="sortedResults"></param>
        /// <returns></returns>
        private Dictionary<int, List<int>> GetTeamHeatSwimmersIDs(List<Result> sortedResults)
        {
            Dictionary<int, List<int>> teamHeatSwimmerIDs = new Dictionary<int, List<int>>();
            int seq = 0;
            int limit = 0;
            teamHeatSwimmerIDs[seq] = new List<int>();
            for (int j = 0; j < sortedResults.Count; )
            {
                limit = j + 4;
                for (int i = j; i < limit; i++)
                {
                    teamHeatSwimmerIDs[seq].Add(sortedResults[j].HeatSwimmerID);
                    j++;
                }
                if (j % 4 == 0 && j < sortedResults.Count)
                {
                    seq++;
                    teamHeatSwimmerIDs[seq] = new List<int>();
                }
            }

            return teamHeatSwimmerIDs;
        }


        /// <summary>
        /// Returns a list of ints with the index representing the place -1 (index 0 = 1st place), and value = number of swimmers that finished in that place
        /// i.e., [3],[0],[0],[1] represents a 3 way tie for first place, [1],[1],[3],[0],[0],[0]  represents a 2 way tie for 3rd place
        /// </summary>
        /// <param name="results"></param>
        /// <param name="points"></param>
        /// <returns></returns>
        private List<int> GetPlaceFinishers(List<Result> sortedResults, int PointListCount, bool IsRelay)
        {
            List<int> placeFinishers = new List<int>();

            sortedResults = sortedResults.Where(r => r.Leg == 1).ToList();

            //add an int for each team in the list --default to one finisher for each place
            for (int i = 0; i < sortedResults.Count; i++)
            {
                placeFinishers.Add(1);
            }

            //determine the number of finishers for each place
            int k = 0;
            int j = 1;

            while (j < placeFinishers.Count)
            {
                while (j < placeFinishers.Count && sortedResults[k].ElapsedTime == sortedResults[j].ElapsedTime)
                {
                    placeFinishers[k] += 1;
                    placeFinishers[j] = 0;
                    j++;
                }
                k = j;
                j++;
            }
            return placeFinishers.Take(PointListCount).ToList();
        }
        #endregion

        public HeatSwimmerCollection GetHeatSwimmersByByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.HeatSwimmerManager.HeatSwimmerGetAllByHeatSheetEventID(HeatSheetEventID);
        }

        //Get Relay Teammates of the given HeatSwimmer
        public HeatSwimmerCollection GetRelayTeammates(int HeatSwimmerID)
        {
            return Ctx.HeatSwimmerManager.HeatSwimmerGetAllRelayTeammatesByHeatSwimmerID(HeatSwimmerID);
        }

        public Stroke GetStrokeByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.StrokeManager.StrokeGetByHeatSheetEventID(HeatSheetEventID);
        }

        public ScoreCollection GetScoresBySwimMeetID(int SwimMeetID)
        {
            return Ctx.ScoreManager.ScoreGetAllBySwimMeetID(SwimMeetID);
        }

        public ScoreCollection GetScoresBySwimMeetIDSystemUserID(int SwimMeetID, int SystemUserID)
        {
            return Ctx.ScoreManager.ScoreGetAllBySwimMeetIDSystemUserID(SwimMeetID, SystemUserID);
        }

        public ScoreCollection GetScoresBySystemUserIDAsSwimmer(int SystemUserID)
        {
            return Ctx.ScoreManager.ScoreGetAllBySystemUserIDAsSwimmer(SystemUserID);
        }

        public ScoreCollection GetTotalScoresBySwimMeetID(int SwimMeetID)
        {
            return Ctx.ScoreManager.ScoreGetTotalBySwimMeetID(SwimMeetID);
        }

        public PoolConfigCollection GetPoolConfigsByCityRegionID(string City, int RegionID)
        {
            if (City.Equals("0"))
            {
                return Ctx.PoolConfigManager.PoolConfigGetAllByRegionID(RegionID);
            }
            else
            {
                return Ctx.PoolConfigManager.PoolConfigGetAllByCityRegionID(City, RegionID);
            }

        }

        /// <summary>
        /// Returns ALL the PoolConfigs at the Location corresponding this Team's HomePoolConfigID
        /// </summary>
        /// <param name="UserTeamID"></param>
        /// <returns></returns>
        public PoolConfigCollection GetPoolConfigsByUserTeamID(int UserTeamID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetAllByUserTeamID(UserTeamID);
        }

        /// <summary>
        /// Returns the PoolConfig corresponding this Team's HomePoolConfigID
        /// </summary>
        /// <param name="UserTeamID"></param>
        /// <returns></returns>
        public PoolConfig GetPoolConfigByUserTeamID(int UserTeamID)
        {
            return Ctx.PoolConfigManager.PoolConfigGetByUserTeamID(UserTeamID);
        }

        public SystemUser GetSystemUserByUserName(string UserName)
        {
            SystemUser su = Ctx.SystemUserManager.SystemUserGetByUserName(UserName);
            return su;
        }

        public void EncryptPasswords()
        {
            SystemUserCollection users = Ctx.SystemUserManager.SystemUserGetAllByResetPassword();
            foreach (SystemUser user in users)
            {
                user.Password = GetMd5Hash(user.Password);
                user.ResetPassword = false;
                Ctx.SystemUserManager.SystemUserSave(user);
            }
        }

        public Season GetSeasonBySeasonIDSystemUserID(int SeasonID, int systemUserID)
        {
            return Ctx.SeasonManager.SeasonGetBySeasonIDSystemUserID(SeasonID, systemUserID);
        }

        /// <summary>
        /// Returns a flag indicating whether the user has current or future TeamSeason records
        /// Used to determine whether a user can create a meet
        /// </summary>
        /// <param name="SystemUserID"></param>
        /// <returns></returns>
        public bool GetHasTeamSeasons(int SystemUserID)
        {
            return Ctx.TeamSeasonManager.TeamSeasonGetAllBySystemUserID(SystemUserID).Count > 0;
        }

        public SystemUser GetSystemUser(int SystemUserID)
        {
            return Ctx.SystemUserManager.SystemUserGet(SystemUserID);
        }

        #region Reports
        public ReportHeatSheetEventCollection GetReportHeatSheetEventByHeatSheetEventID(int HeatSheetEventID)
        {
            return Ctx.ReportManager.RptHeatSheetEventGetByHeatSheetEventID(HeatSheetEventID);
        }
        public ReportHeatSheetEventCollection GetReportHeatSheetEventByHeatID(int HeatID)
        {
            return Ctx.ReportManager.RptHeatSheetEventGetByHeatID(HeatID);
        }

        public ReportHeatSheetEventCollection GetReportHeatSheetEventByHeatSheetID(int HeatSheetID)
        {
            return Ctx.ReportManager.RptHeatSheetEventGetByHeatSheetID(HeatSheetID);
        }
        #endregion
    }
}
