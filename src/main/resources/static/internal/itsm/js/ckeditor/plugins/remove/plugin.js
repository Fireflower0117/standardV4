CKEDITOR.plugins.add('remove', {
    icons: 'remove',
    init: function (editor) {
        editor.addCommand('cmd-remove', {
            exec: function (editor) {
                var paragraphs = editor.editable().find('p');

                for (var i = 0; i < paragraphs.count(); i++) {
                    var paragraph = paragraphs.getItem(i);

                    // 값이 없는 p태그만 제거
                    if (paragraph.getText().trim() === '' && !paragraph.getAscendant('table', true)) {
                        paragraph.remove();
                    }
                }

                var breaks = editor.editable().find('br');
                for (var j = 0; j < breaks.count(); j++) {
                    var lineBreak = breaks.getItem(j);
                    if (!lineBreak.getAscendant('table', true)) {
                        lineBreak.remove();
                    }
                }
            }
        });

        editor.ui.addButton('remove', {
            label: '공백제거',
            command: 'cmd-remove',
            toolbar: 'custom'
        });
    }
});
