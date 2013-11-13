using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using SwimomaticMVC.Models;
using SwimomaticMVC.Helpers;
using System.Configuration;
using Swimomatic.Entity;
using Microsoft.Web.Helpers;
using LAAF.Logger;

namespace SwimomaticMVC.Controllers
{
    public class AccountController : ControllerBase
    {

        public IFormsAuthenticationService FormsService { get; set; }

        protected override void Initialize(RequestContext requestContext)
        {
            try
            {
                if (FormsService == null) { FormsService = new FormsAuthenticationService(); }
                base.Initialize(requestContext);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "ServerVariables=" + requestContext.HttpContext.Request.ServerVariables["ALL_HTTP"], "");
            }
        }

        #region Action Methods
        // **************************************
        // URL: /Account/LogOn
        // **************************************

        public ActionResult LogOn()
        {
            ViewBag.FirstLastName = "";
            return View();
        }

        public ActionResult ResetPassword()
        {
            ResetPassword rp = new ResetPassword();
            return View(rp);
        }

        public ActionResult AccountEdit()
        {
            SwimomaticMVC.Models.AccountEdit accountEdit = null;
            try
            {
                accountEdit = GetAccountEdit(this.CurrentUser.SystemUserID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserName=" + accountEdit.UserName.ToString());
            }
            return View(accountEdit);
        }

        [HttpPost]
        public ActionResult AccountEdit(SwimomaticMVC.Models.AccountEdit model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SystemUser su = new SystemUser();
                    su.City = model.City;
                    su.Email = model.Email;
                    su.FirstName = model.FirstName;
                    su.LastName = model.LastName;
                    su.ModifiedDate = DateTime.Now;
                    su.Password = model.Password; //new password
                    su.RegionID = model.RegionID;
                    su.SystemUserID = model.SystemUserID;
                    su.UserName = model.UserName;
                    BizMgr.SaveAccountEdit(su);

                    //get updated values from db
                    SwimomaticMVC.Models.AccountEdit ae = GetAccountEdit(su.SystemUserID);
                    return View("AccountEditSuccess", ae);
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserName=" + model.UserName.ToString());
            }
            return View(model);
        }
        [HttpPost]
        public ActionResult LogOn(LogOnModel model, string returnUrl)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    //EncryptPasswords();
                    SystemUser su = BizMgr.ValidateUser(model.UserName, model.Password);
                    if (su.SystemUserID > 0 && su.IsActive)
                    {
                        FormsService.SignIn(model.UserName, model.RememberMe);
                        SetCurrentUser(su);

                        if (!String.IsNullOrEmpty(returnUrl))
                        {
                            return Redirect(returnUrl);
                        }
                        else
                        {
                            return RedirectToAction("Index", "Home");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", "The user name or password provided is incorrect.");
                    }
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserName=" + model.UserName.ToString());
            }

            // If we got this far, something failed, redisplay form
            return View(model);
        }

        // **************************************
        // URL: /Account/LogOff
        // **************************************

        public ActionResult LogOff()
        {
            try
            {
                FormsService.SignOut();
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserID=" + this.CurrentUser.SystemUserID.ToString());
            }
            return RedirectToAction("Index", "Home");
        }

        // **************************************
        // URL: /Account/Register
        // **************************************

        public ActionResult Register()
        {
            RegisterModel rg = new RegisterModel();
            rg.Regions = GetRegions(0);
            rg.RegionID = 0;
            return View(rg);
        }

        private void EncryptPasswords()
        {
            BizMgr.EncryptPasswords();
        }

        [HttpPost]
        public ActionResult Register(RegisterModel model)
        {
            try
            {
                string captchaKey = ConfigurationManager.AppSettings["ReCaptchaPrivateKey"];
                if (ReCaptcha.Validate(privateKey: captchaKey))
                {
                    if (ModelState.IsValid)
                    {
                        MembershipCreateStatus createStatus = BizMgr.CreateUser(model.City, model.Email, model.FirstName, model.LastName, model.Password, model.RegionID);
                        if (createStatus == MembershipCreateStatus.Success)
                        {
                            model.SuccessMessage = string.Format(BizMgr.ReadResourceValue("Email", "RegistrationSuccessMessage"), model.Email);
                            model.City = string.Empty;
                            model.ConfirmPassword = string.Empty;
                            model.Email = string.Empty;
                            model.FirstName = string.Empty;
                            model.LastName = string.Empty;
                            model.Password = string.Empty;
                        }
                        else
                        {
                            ModelState.AddModelError("", AccountValidation.ErrorCodeToString(createStatus));
                            ViewBag.PasswordFormat = AccountValidation.PasswordFormatMessage;
                        }
                    }
                }
                else
                {
                    ModelState.AddModelError("Captcha", "You did not enter the Captcha values correctly. Please try again.");
                    ViewBag.PasswordFormat = AccountValidation.PasswordFormatMessage;
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "Email=" + model.Email);
            }
            model.Regions = GetRegions(0);
            return View(model);
        }

        public ActionResult ConfirmRegistration(string id)
        {
            try
            {
                Guid registrationKey = new Guid(id);
                SystemUser su = BizMgr.ConfirmRegistration(registrationKey);
                if (su.SystemUserID > 0)
                {
                    FormsService.SignIn(su.Email, false /* createPersistentCookie */);
                    return RedirectToAction("Index", "Home");
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "registrationKey=" + id);
            }
            return new EmptyResult();
        }

        public ActionResult ConfirmResetPassword(string id)
        {
            try
            {
                Guid registrationKey = new Guid(id);
                SystemUser su = BizMgr.ConfirmPasswordReset(registrationKey);
                if (su.SystemUserID > 0)
                {
                    FormsService.SignIn(su.Email, false /* createPersistentCookie */);
                    PasswordEdit pe = new PasswordEdit();
                    pe.SystemUserID = su.SystemUserID;
                    return View("PasswordEdit", pe);
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "registrationKey=" + id);
            }
            return View("ResetPasswordFail");
        }

        /// <summary>
        /// This method is called when the user posts their user name in order to begin the password reset process
        /// </summary>
        /// <param name="UserName"></param>
        /// <returns></returns>
        [HttpPost]
        public ActionResult ResetPassword(ResetPassword model)
        {
            try
            {
                string captchaKey = ConfigurationManager.AppSettings["ReCaptchaPrivateKey"];
                if (ReCaptcha.Validate(privateKey: captchaKey))
                {
                    SystemUser su = BizMgr.EmailTemporaryPassword(model.UserName);
                    if (su.SystemUserID > 0)
                    {
                        return ResetPasswordSuccess(su);
                    }
                }
                else
                {
                    ModelState.AddModelError("Captcha", "You did not enter the Captcha values correctly. Please try again.");
                    ViewBag.PasswordFormat = AccountValidation.PasswordFormatMessage;
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserName=" + model.UserName);
            }
            return View(model);
        }

        [HttpPost]
        public ActionResult PasswordEdit(PasswordEdit model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    SystemUser su = new SystemUser();
                    su.ModifiedDate = DateTime.Now;
                    su.Password = model.NewPassword; //new password
                    su.TemporaryPassword = model.TemporaryPassword; //new password
                    su.SystemUserID = model.SystemUserID;
                    su = BizMgr.SavePasswordEdit(su);

                    FormsService.SignIn(su.UserName, false);
                    SetCurrentUser(su);

                    return RedirectToAction("PasswordEditSuccess","Account");
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "SystemUserID=" + model.SystemUserID.ToString());
            }
            return View(model);
        }

        public ActionResult PasswordEditSuccess()
        {
            return View();
        }

        public ActionResult ResetPasswordSuccess(SystemUser su)
        {
            ViewBag.Email = su.Email;
            return View("ResetPasswordSuccess");
        }

        #endregion

        #region Private Methods
        private Models.AccountEdit GetAccountEdit(int SystemUserID)
        {
            SwimomaticMVC.Models.AccountEdit ae = new AccountEdit();
            SystemUser su = BizMgr.GetSystemUser(SystemUserID);
            ae.City = su.City;
            ae.ConfirmPassword = string.Empty;
            ae.Email = su.Email;
            ae.FirstName = su.FirstName;
            ae.LastName = su.LastName;
            ae.Password = string.Empty;
            ae.RegionID = su.RegionID;
            ae.Regions = GetRegions(su.RegionID);
            ae.UserName = su.UserName;
            return ae;
        }
        #endregion


    }
}
