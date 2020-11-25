const post = function() {
  const addPlan = document.getElementById("add-plan")
  addPlan.addEventListener("click", () => {
    const insertPlan = document.getElementById("test")
    insertPlan.setAttribute("style", "display: block");
  })

  const sendButton = document.getElementById("commit")
  sendButton.addEventListener("click", (e) => {
    const formData = new FormData(document.getElementById("form"));
    const XHR = new XMLHttpRequest();
    XHR.open("POST", "/posts", true);
    XHR.responseType = "json";
    XHR.send(formData)

  })
}

window.addEventListener("load", post)