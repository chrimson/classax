function go() {
 $('#status').html('<i class="fa fa-cog fa-spin" style="font-size:30px;color:gray;"></i>');

 $.ajax({
  url: '/classax/',
  method: 'POST',
//  data: {
//   m: $('#id').val(),
//   a: $('#id2').val()
//  },

  dataType: 'html',
  success: function success(html) {
   $('#status').html(html);
  }
 });

// alert("go okay!");
};

$(document).click(function(e) {
  if (e.target.id == "go") {
    go();
  }
});
