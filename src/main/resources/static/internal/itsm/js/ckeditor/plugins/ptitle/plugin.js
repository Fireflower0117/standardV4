CKEDITOR.plugins.add('ptitle', {
    icons: 'ptitle',
    init: function (editor) {
        editor.addCommand('cmd-ptitle', {
            exec: function (editor) {
                var selection = editor.getSelection();
                var ranges = selection.getRanges();

                for (var i = 0; i < ranges.length; i++) {
                    var selectedElement = ranges[i].getCommonAncestor();

                    if (selectedElement && !isWhitespace(selectedElement.getText())) {
                        var titleDiv = new CKEDITOR.dom.element('div');
                        titleDiv.addClass('title');

                        var strong = new CKEDITOR.dom.element('strong');
                        strong.append(ranges[i].cloneContents());

                        titleDiv.append(strong);

                        selectedElement.$.parentNode.replaceChild(titleDiv.$, selectedElement.$);
                    }
                }

                // Remove empty paragraphs
                var editorContent = editor.getData();
                editorContent = editorContent.replace(/<p>&nbsp;<\/p>/g, '');

                // Add a newline after the inserted content
                editorContent += '<p>&nbsp;</p>';
                
                editor.setData(editorContent);

                var endElement = editor.document.getBody().getLast();
                var range = editor.createRange();
                range.setStartAt(endElement, CKEDITOR.POSITION_BEFORE_END);
                range.collapse(true);
                selection.selectRanges([range]);
            }
        });

        editor.ui.addButton('ptitle', {
            label: '타이틀',
            command: 'cmd-ptitle',
            toolbar: 'custom'
        });
    }
});

function isWhitespace(str) {
    return !str.trim();
}
