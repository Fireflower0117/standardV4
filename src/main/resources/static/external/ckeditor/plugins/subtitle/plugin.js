CKEDITOR.plugins.add('subtitle', {
    icons: 'subtitle',
    init: function (editor) {
        editor.addCommand('cmd-subtitle', {
            exec: function (editor) {
                var selectedElement = editor.getSelection().getStartElement();
                var cellElement = selectedElement.getAscendant('td', true) || selectedElement.getAscendant('th', true);

                if (cellElement) {
                    var cellContent = cellElement.getHtml();
                    var cleanContent = cellContent.replace(/<p[^>]*>([\s\S]*?)<\/p>/gi, '$1');
                    var newContent = '<div class="smtitle">' + cleanContent + '</div>';
                    cellElement.setHtml(newContent);
                }
            }
        });

        editor.ui.addButton('subtitle', {
            label: '테이블 서브타이틀',
            command: 'cmd-subtitle',
            toolbar: 'custom'
        });
    }
});
 