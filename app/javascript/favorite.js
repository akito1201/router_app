const favorite = () => {
  
  const favoriteClick = document.getElementById("favorite-btn");
  const favoriteText = document.getElementById("favorite")

    favoriteClick.addEventListener("click", () => {
      const PostId = favoriteClick.getAttribute("data_id");
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `/posts/${PostId}/favorites`, true);
      XHR.responseType = "json";
      XHR.send();

      XHR.onload = () => {
        const post = XHR.response.post
        if (post.checked == true) {
          favoriteClick.setAttribute("style", "background-color: #FF6600; color: white;")
          favoriteText.innerHTML = "お気に入り登録済み"
          
        } else if (post.checked == false) {
          favoriteClick.setAttribute("style", "background-color: white;")
          favoriteText.innerHTML = "お気に入りに登録する"
        };
        const count = XHR.response.count
        const XHRB = new XMLHttpRequest();
        XHRB.open("GET", `/posts/${PostId}/favorite_counts/${count}`, true);
        XHRB.send();

      }
    });
    }

    window.addEventListener('load', favorite)