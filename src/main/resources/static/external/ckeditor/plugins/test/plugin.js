CKEDITOR.plugins.add('test', {
    icons: 'test',
    init: function (editor) {
        editor.addCommand('cmd-test', {
            exec: function (editor) {

            	var selection = editor.getSelection();

                var selectedText = selection.getSelectedText();

                var scriptTag = editor.document.createElement('script');
                scriptTag.setAttribute('type', 'text/javascript');
                scriptTag.setText(selectedText);

                editor.insertElement(scriptTag);
            }
        });

        editor.ui.addButton('test', {
            label: '빨간색',
            command: 'cmd-test',
            toolbar: 'custom'
        });
    }
});
