//= require jsoneditor-min


$(document).ready(function() {

    var t = '', activeProperty;
    var locationProp = document.getElementById('location_property'),
        answerProp = document.getElementById('answer_property');

    function gText(e) {
        t = (document.all) ? document.selection.createRange().text : document.getSelection();

        activeProperty.value = t;
    }

    function setActiveProperty(input) {
        $(activeProperty).removeClass('activeProperty')
        activeProperty = input;
        $(activeProperty).addClass('activeProperty')
    }

    locationProp.onfocus = function() {
        setActiveProperty(locationProp);
    }

    answerProp.onfocus = function() {
        setActiveProperty(answerProp);
    }

    $('query_hash').on('mouseup', gText);

    var container = document.getElementById("jsoneditor");
    var editor = new jsoneditor.JSONEditor(container);

    /**
     * Before form is submitted,
     */
    $('.edit_question_template').submit(function(e) {
        e.preventDefault;
        extractJson();
        this.submit();
    });

    /**
     * Parse value of query_hash field and set it as content of the editor.
     */
    function infuseJson() {
        editor.set(JSON.parse($('#query_hash').val()));
    };

    /**
     * Stringify the content of the editor and set it as value of query_hash field.
     */
    function extractJson() {
        $('#query_hash').val(JSON.stringify(editor.get()));
    };

    infuseJson();
})
