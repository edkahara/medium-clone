$(document).on('ready page:load', function() {
  if (typeof tinyMCE != 'undefined') {
    tinyMCE.init({
      selector: "textarea.tinymce",
      content_css: 'application.scss',
      relative_urls: false,
      toolbar: [
        "styleselect | undo redo | bold italic underline superscript subscript | alignleft aligncenter alignright alignjustify | numlist bullist | outdent indent | uploadimage image media link | code codesample | preview"
      ],
      plugins: "autoresize,charmap,code,codesample,hr,image,imagetools,link,lists,media,preview,searchreplace,table,uploadimage,wordcount"
    });
  } else {
    setTimeout(arguments.callee, 50);
  }
});
