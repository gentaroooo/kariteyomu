function previewImage(){
    const target = this.event.target
    const file = target.files[0]
    const reader = new FileReader()
    reader.onloadend = function(){
      const preview = document.getElementById('preview')
      if(preview){
        preview.src = reader.result
      }
    }
    if(file){
      reader.readAsDataURL(file)
    }
  }
  
  document.addEventListener('turbolinks:load', () => {
    const fileFiled = document.getElementById("file-field")
    if(fileFiled){
      fileFiled.addEventListener("change", () => { previewImage() })
    }
  })