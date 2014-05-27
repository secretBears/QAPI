function initPage() {
    var container = $("#jsoneditor")[0];

    var editor;

    if(container) {
        editor = new jsoneditor.JSONEditor(container);
        infuseJson();
    }

    /**
     * Before form is submitted,
     */
    $('.question_template_form').on('submit', function(e) {
        e.preventDefault();
        extractJson();
        this.submit();
    });

    /**
     * Parse value of query_hash field and set it as content of the editor.
     */
    var infuseJson = function infuseJson() {
        editor.set(JSON.parse($('#query_hash').val()));
    };

    /**
     * Stringify the content of the editor and set it as value of query_hash field.
     */
    var extractJson = function extractJson() {
        $('#query_hash').val(JSON.stringify(editor.get()));
    };


    window.QAPI = window.QAPI || {};
    window.QAPI.editor = editor;
    window.QAPI.extractFromEditor = extractJson;


};  

$(window).on('page:change', initPage);
