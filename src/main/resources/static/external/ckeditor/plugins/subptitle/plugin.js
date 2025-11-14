CKEDITOR.plugins.add('subptitle', {
    icons: 'subptitle',
    init: function (editor) {
        editor.addCommand('cmd-subptitle', {
        	exec: function (editor) {
                var selection = editor.getSelection();
                var ranges = selection.getRanges();

                for (var i = 0; i < ranges.length; i++) {
                    var selectedElement = ranges[i].getCommonAncestor();

                    if (selectedElement && !isWhitespace(selectedElement.getText())) {
                        var titleDiv = new CKEDITOR.dom.element('div');
                        titleDiv.addClass('smtitle');

                        var strong = new CKEDITOR.dom.element('strong');
                        strong.append(ranges[i].cloneContents());

                        titleDiv.append(strong);

                        selectedElement.$.parentNode.replaceChild(titleDiv.$, selectedElement.$);
                    }
                }

                var editorContent = editor.getData();
                editorContent = editorContent.replace(/<p>&nbsp;<\/p>/g, '');

                editorContent += '<p>&nbsp;</p>';
                
                editor.setData(editorContent);

                var endElement = editor.document.getBody().getLast();
                var range = editor.createRange();
                range.setStartAt(endElement, CKEDITOR.POSITION_BEFORE_END);
                range.collapse(true);
                selection.selectRanges([range]);
            }
        });

        editor.ui.addButton('subptitle', {
            label: '서브타이틀',
            command: 'cmd-subptitle',
            toolbar: 'custom'
        });
    }
});

function isWhitespace(str) {
    return !str.trim();
}
