// $(document).ready(function(){ 
  
//     $.ajax({
//       type: 'GET',
//       url: 'https://api.calil.jp/check',
//       data:{
//         appkey: '02023e9215dd8abf24623c38a882a764',
//         isbn: 4033280103,
//         systemid: 'Kanagawa_Hiratsuka',
//       },
//       dataType: 'jsonp',
//       jsonp: 'callback',//コールバックパラメータ名の指定
//       //jsonpCallback: 'testCallback',//callback関数名を自分で指名した場合
//     })
//     .done(function(data){
//       console.log(data)
        
//     })
//     .fail(function(data){
//       $("#jsonp").append("エラーです");
//   });
// });