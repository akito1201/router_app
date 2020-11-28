const post = function() {
  
  const addPlan = document.getElementById("add-plan");

// プランを追加するボタンを押したときの処理
  addPlan.addEventListener("click", () => {
  // 入力された内容を送信し保存
    const formResult = document.getElementById("form");
    const postId = document.getElementById("plan-wrapper");
    const plan = postId.getAttribute("data-id");
    console.log(postId);
    const formData = new FormData(formResult);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/posts/${plan}/plans`, true);
    XHR.send(formData);
    window.location.href = `/posts/${plan}/plans/new`;
    });
  }

window.addEventListener("load", post)