  $(".alert").remove()
  $(".address_library").remove()
  $('#address_parent').html('<p class="address_library"></p>')

  $.ajax({
      type: 'GET',
      url: 'https://api.calil.jp/library',
      data:{
          appkey: "<%= ENV['APP_KEY'] %>",
          format: "json",
          geocode: `${gon.longitude},${gon.latitude}`,
          limit: 20,
          callback: 'no',
      },
      dataType: 'json',
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
    })
    // 重複を削除した値
    console.log(filterData)

    $(".address_library").remove()
    $('#address_parent').html('<p class="address_library m-3"></p>')
    $('.address_library').after('<button type="button" class="btn btn-success m-3">登録する</button>')
    //重複を削除したfilterDataをひとつずつvalueに格納
    Object.keys(filterData).forEach( function(value) {
      //チェックボックスで地域名を表示する(valueはsystemid）
      $(".address_library").prepend(`<label><input type=radio name=chk1 value=${this[value].systemid}>${this[value].systemname}</label>`)
    }, filterData)
    //チェックボックスをクリックしたら発火
    $('button').click(function() {
      $(".alert").remove()
      //すべてのチェック済みvalue値を取得する
      var libraryArea = $("input[name='chk1']:checked").parent().text();
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
            display:libraryArea,
            }
          },
        })
        $(".flash").prepend('<div class="alert alert-success" role="alert">図書館情報を登録しました');
      })
    })
  })
  //POSTに失敗した場合
  .fail(function(data){
    console.log("失敗")
    console.log(data)
  })