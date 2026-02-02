(function (window) {

    if (!window.on) {
        window.on = {};
    }

    window.on.xhr   = window.xhrFns;
    window.on.str   = window.stringFns;
    window.on.valid = window.validateFns;
    window.on.msg   = window.messageFns;
    window.on.host  = window.hostFns;
    window.on.html  = window.htmlFns;
    window.on.date  = window.dateFns;
    window.on.file  = window.fileFns;
    window.on.enc   = window.encryptionFns;

})(window);
