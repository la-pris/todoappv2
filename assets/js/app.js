// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
// import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html";
// Establish Phoenix Socket and LiveView configuration.
import { Socket } from "phoenix";
import { LiveSocket } from "phoenix_live_view";
import topbar from "../vendor/topbar";

let Hooks = {};

function isBefore(el1, el2) {
  if (el2.parentNode === el1.parentNode)
    for (
      var cur = el1.previousSibling;
      cur && cur.nodeType !== 9;
      cur = cur.previousSibling
    )
      if (cur === el2) return true;
  return false;
}
Hooks.draggable_hook = {
  mounted() {
    let dragel;

    this.el.addEventListener("dragstart", (e) => {
      console.log(el.parentNode);
      e.dataTransfer.dropEffect = "move";
      e.dataTransfer.setData("text/plain", e.target.id);
      dragel = e.target;
    });

    this.el.addEventListener("dragover", (e) => {
      e.preventDefault();
      e.dataTransfer.dropEffect = "move";
      // console.log(e.target);
      if (isBefore(dragel, e.target))
        e.target.parentNode.insertBefore(dragel, e.target);
      else e.target.parentNode.insertBefore(dragel, e.target.nextSibling);
    });
    // this.el.addEventListener("dragover", e => {
    //     e.preventDefault();
    //     e.dataTransfer.dropEffect = "move";
    // })

    // this.el.addEventListener("drop", e => {
    //     e.preventDefault();
    //     var data = e.dataTransfer.getData("text/plain");
    //     this.el.appendChild(e.view.document.getElementById(data));
    // })
  },
};

// Hooks.drop_zone = {
//     mounted() {

// this.el.addEventListener("drop", e => {
//   e.preventDefault();
//   var data = e.dataTransfer.getData("text/plain");
// this.el.appendChild(e.view.document.getElementById(data));
// if (el != current) {
//     let currentpos = 0, droppedpos = 0;
//     for (let it=0; it<items.length; it++) {
//       if (current == items[it]) { currentpos = it; }
//       if (i == items[it]) { droppedpos = it; }
//     }
//     if (currentpos < droppedpos) {
//       i.parentNode.insertBefore(current, i.nextSibling);
//     } else {
//       i.parentNode.insertBefore(current, i);
//     }
// }
//     })
//   }
// }

let csrfToken = document
  .querySelector("meta[name='csrf-token']")
  .getAttribute("content");
let liveSocket = new LiveSocket("/live", Socket, {
  params: { _csrf_token: csrfToken },
  hooks: Hooks,
});

// Show progress bar on live navigation and form submits
topbar.config({ barColors: { 0: "#29d" }, shadowColor: "rgba(0, 0, 0, .3)" });
window.addEventListener("phx:page-loading-start", (info) => topbar.show());
window.addEventListener("phx:page-loading-stop", (info) => topbar.hide());

// connect if there are any LiveViews on the page
liveSocket.connect();

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket;
