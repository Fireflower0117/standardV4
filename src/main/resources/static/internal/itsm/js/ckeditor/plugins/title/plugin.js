CKEDITOR.plugins.add('title', {
    icons: 'title',
    init: function (editor) {
        editor.addCommand('cmd-title', {
            exec: function (editor) {
                var selection = editor.getSelection();
                var ranges = selection.getRanges();

                var commonAncestor = ranges[0].getCommonAncestor();

                if ($(commonAncestor.$).is('p') && $(commonAncestor.$).closest('table').length > 0) {
                    var pContent = commonAncestor.getOuterHtml();
                    var newContent = '<div class="title">' + pContent + '</div>';
                    ranges[0].deleteContents();
                    ranges[0].insertHtml(newContent);
                } else if ($(commonAncestor.$).is('p')) {
                    var pContent = commonAncestor.getHtml();
                    var newContent = '<div class="title">' + pContent + '</div>';
                    ranges[0].deleteContents();
                    ranges[0].insertHtml(newContent);
                } else {
                    var selectedElement = selection.getStartElement();
                    var tdElement = selectedElement.getAscendant('td', true) || selectedElement.getAscendant('th', true);

                    if (tdElement) {
                        var tdElements = tdElement.getParent().getChildren();

                        for (var i = 0; i < tdElements.count(); i++) {
                            var currentTd = tdElements.getItem(i);
                            var tdContent = currentTd.getHtml();

                            var contentWithoutPTags = tdContent.replace(/<\/?p>/g, '');

                            var newContent = '<div class="title">' + contentWithoutPTags + '</div>';

                            currentTd.setHtml(newContent);
                        }
                    }
                }
            }
        });

        editor.ui.addButton('title', {
            label: '테이블 타이틀',
            command: 'cmd-title',
            toolbar: 'custom'
        });
    }
});
