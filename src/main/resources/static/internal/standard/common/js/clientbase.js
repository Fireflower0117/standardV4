    /**  XML HttpRequest Functions **/
    import xhrFns from './stanbasic/stanBasicXhrFns.js';

    /** String Functions **/
    import stringFns from './stanbasic/stanBasicStringFns.js';

    /** validate Functions  **/
    import validateFns from './stanbasic/stanBasicValidFns.js';

    /** Message Functions  **/
    import messageFns from './stanbasic/stanBasicMessageFns.js';

    /** Host Functions  **/
    import hostFns from './stanbasic/stanBasicHostFns.js';

    /** Html Functions  **/
    import htmlFns from './stanbasic/stanBasicHtmlFns.js';

    /** Date Functions  **/
    import dateFns from './stanbasic/stanBasicDateFns.js';

    /** Date Functions  **/
    import fileFns from './stanbasic/stanBasicFileFns.js';

    /** Encrypt Functions  **/
    import encFns from './stanbasic/stanBasicEncryptionFns.js';

    // DOM 준비되면 $.opnt 정의
    let opnt = {
           xhr : xhrFns
         , str : stringFns
         , valid : validateFns
         , host : hostFns
         , msg : messageFns
         , html : htmlFns
         , date : dateFns
         , file : fileFns
         , enc  : encFns
    };

    export default opnt;
