const favorite = () => {
  
  const favoriteClick = document.getElementById("favorite-btn");
  const favoriteText = document.getElementById("favorite")

    favoriteClick.addEventListener("click", () => {
      const PostId = favoriteClick.getAttribute("data_id");
      console.log(PostId);
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/posts/${PostId}/favorites`, true);
      XHR.responseType = "json";
      XHR.send();

      XHR.onload = () => {
        const post = XHR.response.post
        console.log(post)
        if (post.checked == true) {
          favoriteClick.setAttribute("style", "background-color: #FF6600; color: white;")
          favoriteText.innerHTML = "お気に入り登録済み"
          
        } else if (post.checked == false) {
          favoriteClick.setAttribute("style", "background-color: white;")
          favoriteText.innerHTML = "お気に入りに登録する"
        }
      }
    });
    }

    window.addEventListener('load', favorite)