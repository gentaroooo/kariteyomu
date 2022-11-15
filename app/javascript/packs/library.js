$(document).on('turbolinks:load', function() {

// $('js-address').on('click', function() {
  // if (gon.latitude === undefined){
  // console.log("緯度経度がないよ")
  // }else{
  // debugger
  //前回の図書館情報を削除してlibraryを追加
  $(".library").remove()
  $('#parent').html('<p class="library"></p>')
  // if( navigator.geolocation ){
    // // 位置情報を取得する
    // navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
      
      // 緯度を取得
      // debugger
      // var address_latitude = gon.latitude;
      // 経度を取得
      // debugger
      // var address_longitude = gon.longitude;
      //取得した緯度経度から近隣の図書館を検索

      $.ajax({
          type: 'GET',
          url: 'https://api.calil.jp/library',
          data:{
              appkey: "<%= ENV['APP_KEY'] %>",
              format: "json",
              geocode: `${gon.longitude},${gon.latitude}`,
              limit: 20,
          },
          dataType: 'jsonp',
          jsonp: 'callback'
      })

      //図書館検索に成功した場合JSONをdataに格納
      .done(function(data){
        console.log("成功")
        console.log(data)
        //dataの並び順を逆にする
        data.reverse();
        var filterData = data.filter((item, index, self) => {
          // systemidだけをリスト化する
          var nameList = self.map(item => item['systemid'])
            // systemidの重複を削除する
            if (nameList.indexOf(item.systemid) === index) {
                return item;
            }
            
            // systemidにUniv_（大学）が含まれていれば削除する
            // if(nameList.filter(item => (item.match(/Univ_/)) == null)) {
            //   return item;
            // }
            //  debugger
            // var removals = ['Univ_'];
            // animals = animals.filter(function(v){
            //   return ! removals.includes(v);
            // });
            // console.log('animals : ', animals);
            // var cats_before = cats.filter(item => (item.match(/シ/)) == null)

        })
        // 重複を削除した値
        console.log(filterData)

        $(".library").remove()
        $('#parent').html('<p class="library m-3"></p>')
        $('.library').after('<button type="button" class="btn btn-success m-3">登録する</button>')
        //重複を削除したfilterDataをひとつずつvalueに格納
        Object.keys(filterData).forEach( function(value) {
          //チェックボックスで地域名を表示する(valueはsystemid）
          $(".library").prepend(`<input type=radio name=chk1 value=${this[value].systemid}>
          ${this[value].systemname}`)
        }, filterData)
        //チェックボックスをクリックしたら発火
        $('button').click(function() {
          //すべてのチェック済みvalue値を取得する
          $('input:checked').each(function() {
            //libraryNameにチェック済みの値を代入する
            var libraryName = $(this).val();
            console.log(libraryName);
            //libraryNameをlibrariesにPOSTする
            $.ajax({
              type: "POST",
              url: '/libraries/',
              data: {
                library: {
                name:libraryName,
                }
              },
            })
          })
        })
      })
      //POSTに失敗した場合
      .fail(function(data){
          console.log("失敗")
          console.log(data)
          $("#jsonp").append("エラーです")
          window.alert('位置情報の取得に失敗しました。エラーコード：' + error.code)
      })
    // }
// });
});