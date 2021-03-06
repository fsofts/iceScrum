(function($) {
    "use strict";
    if (isSettings.lang === 'es') {
        jQuery.timeago.settings.strings = {
            prefixAgo: "hace",
            prefixFromNow: "en",
            suffixAgo: "",
            suffixFromNow: "",
            seconds: "menos de un minuto",
            minute: "un minuto",
            minutes: "unos %d minutos",
            hour: "una hora",
            hours: "%d horas",
            day: "un día",
            days: "%d días",
            month: "un mes",
            months: "%d meses",
            year: "un año",
            years: "%d años"
        };
    }
})(jQuery);