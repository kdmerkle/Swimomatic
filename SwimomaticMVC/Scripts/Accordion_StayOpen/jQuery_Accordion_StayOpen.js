$(function () {
    $("#accordion").accordion({ active: false });

    $("#notaccordion").addClass("ui-accordion ui-widget ui-helper-reset")
		.find("h3")
			.addClass("ui-accordion-header ui-helper-reset ui-state-default ui-corner-top ui-corner-bottom")
			.prepend('<span class="ui-icon ui-icon-triangle-1-e"/>')
			.click(function () {
			    $(this).toggleClass("ui-accordion-header-active").toggleClass("ui-state-active")
					.toggleClass("ui-state-default").toggleClass("ui-corner-bottom")
				.find("> .ui-icon").toggleClass("ui-icon-triangle-1-e").toggleClass("ui-icon-triangle-1-s")
				.end().next().toggleClass("ui-accordion-content-active").toggle();
			    return false;
			})
			.next().addClass("ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom").hide();
})
