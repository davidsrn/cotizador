window.onload = () => {
  const removeElement = ({target}) => {
    let el = document.getElementById(target.dataset.id);
    let li = el.parentNode;
    li.parentNode.removeChild(li);
  }
  Array.from(document.querySelectorAll(".remove-form-field"))
  .forEach(el => {
     el.onclick = (e) => {
       removeElement(e);
     }
  });
  Array.from(document.querySelectorAll(".add-form-field"))
  .forEach(el => {
    el.onclick = ({target: {dataset}}) => {
      let container = document.getElementById(dataset.container);
      let index = container.dataset.index;
      let newRow = dataset.prototype;
      container.insertAdjacentHTML("beforeend",       newRow.replace(/__name__/g, index));
      container.dataset.index = parseInt(container.dataset.index) + 1;
      container.querySelector("a.remove-form-field").onclick = (e) => {
        removeElement(e);
      }
    }
  });
  document.getElementById("add").onclick = function() {
      //First things first, we need our text:
      var text = document.getElementById("idea").value; //.value gets input values

      //Now construct a quick list element
      var li = "<li>" + text + "</li>";

      //Now use appendChild and add it to the list!
      document.getElementById("list").appendChild(li);
  }
}
document.getElementById("add").onclick = function() {
    //First things first, we need our text:
    var text = document.getElementById("idea").value; //.value gets input values

    //Now construct a quick list element
    var li = "<li>" + text + "</li>";

    //Now use appendChild and add it to the list!
    document.getElementById("list").appendChild(li);
}
