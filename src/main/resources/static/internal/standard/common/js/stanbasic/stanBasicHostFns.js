(function(window) {
    const hostFns = {
        getContextPath : function(msg) {
            var hostIndex = location.href.indexOf(location.host) + location.host.length;
            return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
        },
        hostContextPath : function(msg) {
            return location.protocol + "//" + location.host + hostFns.getContextPath();
        }

    }

    window.hostFns = hostFns;
})(window);