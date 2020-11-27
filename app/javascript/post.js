const post = function() {
  
  const addPlan1 = document.getElementById("add-plan1");
  const addPlan2 = document.getElementById("add-plan2");
  const addPlan3 = document.getElementById("add-plan3");
  const addPlan4 = document.getElementById("add-plan4");

// プランを追加するボタンを押したときの処理
  addPlan1.addEventListener("click", () => {
  // 入力された内容を送信し保存
    const formResult = document.getElementById("form");
    const postId = document.getElementById("plan-wrapper");
    const plan = postId.getAttribute("data-id");
    console.log(postId);
    const formData = new FormData(formResult);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/posts/${plan}/plans`, true);
    XHR.send(formData);
    // 次のフォームを表示、投稿ボタン非表示
    let hiddenPlan = document.getElementById("plan1");
    let submitBtn = document.getElementById("submit");
    let hiddenBtn = document.getElementById("submit1");
    submitBtn.setAttribute("style", "display: none;");
    hiddenBtn.setAttribute("style", "display: block;");
    hiddenPlan.setAttribute("style", "display: block");
    addPlan1.setAttribute("style", "display: none");
    addPlan2.setAttribute("style", "display: block");
    }),


    // プランを追加するボタンを押したときの処理
  addPlan2.addEventListener("click", () => {
    // 入力された内容を送信し保存
      const formResult = document.getElementById("form1");
      const postId = document.getElementById("plan-wrapper");
      const plan = postId.getAttribute("data-id");
      console.log(postId);
      const formData = new FormData(formResult);
      const XHR = new XMLHttpRequest();
      XHR.open("POST", `/posts/${plan}/plans`, true);
      XHR.send(formData);
      // 次のフォームを表示
      let hiddenPlan = document.getElementById("plan2");
      let submitBtn = document.getElementById("submit1");
      let hiddenBtn = document.getElementById("submit2");
      submitBtn.setAttribute("style", "display: none;");
      hiddenBtn.setAttribute("style", "display: block;");
      hiddenPlan.setAttribute("style", "display: block");
      addPlan2.setAttribute("style", "display: none");
      addPlan3.setAttribute("style", "display: block");
      }),


    // プランを追加するボタンを押したときの処理
    addPlan3.addEventListener("click", () => {
      // 入力された内容を送信し保存
        const formResult = document.getElementById("form2");
        const postId = document.getElementById("plan-wrapper");
        const plan = postId.getAttribute("data-id");
        console.log(postId);
        const formData = new FormData(formResult);
        const XHR = new XMLHttpRequest();
        XHR.open("POST", `/posts/${plan}/plans`, true);
        XHR.send(formData);
        // 次のフォームを表示
        let hiddenPlan = document.getElementById("plan3");
        let submitBtn = document.getElementById("submit2");
        let hiddenBtn = document.getElementById("submit3");
        submitBtn.setAttribute("style", "display: none;");
        hiddenBtn.setAttribute("style", "display: block;");
        hiddenPlan.setAttribute("style", "display: block");
        addPlan3.setAttribute("style", "display: none");
        addPlan4.setAttribute("style", "display: block");
        }),
  

// プランを追加するボタンを押したときの処理
    addPlan4.addEventListener("click", () => {
      // 入力された内容を送信し保存
        const formResult = document.getElementById("form3");
        const postId = document.getElementById("plan-wrapper");
        const plan = postId.getAttribute("data-id");
        console.log(postId);
        const formData = new FormData(formResult);
        const XHR = new XMLHttpRequest();
        XHR.open("POST", `/posts/${plan}/plans`, true);
        XHR.send(formData);
        // 次のフォームを表示
        let hiddenPlan = document.getElementById("plan4");
        let submitBtn = document.getElementById("submit3");
        let hiddenBtn = document.getElementById("submit4");
        submitBtn.setAttribute("style", "display: none;");
        hiddenBtn.setAttribute("style", "display: block;");
        hiddenPlan.setAttribute("style", "display: block");
        addPlan4.setAttribute("style", "display: none");
        })


  }


window.addEventListener("load", post)