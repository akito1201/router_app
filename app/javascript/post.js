const post = function() {
  // const addPlan = document.getElementById("add-plan")
  // addPlan.addEventListener("click", () => {
  //   const insertPlan = document.getElementById("test")
  //   insertPlan.setAttribute("style", "display: block");
  // })

  const sendButton = document.getElementById("add-plan")
  sendButton.addEventListener("click", () => {
    const formResult = document.getElementById("form");
    const postId = document.getElementById("plan-wrapper");
    const plan = postId.getAttribute("data-id");
    console.log(postId);
    const formData = new FormData(formResult);
    const XHR = new XMLHttpRequest();
    XHR.open("POST", `/posts/${plan}/plans`, true);
    XHR.send(formData);
    })

    // XHR.responseType = "json";
    // console.log(formData)
    // XHR.onload = () => {
    //   const postTest = XHR.response.post;
    //   console.log(postTest)
    // };
  }

window.addEventListener("load", post)