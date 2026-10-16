"use strict";var H=Object.create;var p=Object.defineProperty;var Z=Object.getOwnPropertyDescriptor;var Y=Object.getOwnPropertyNames;var q=Object.getPrototypeOf,X=Object.prototype.hasOwnProperty;var Q=(e,t)=>{for(var r in t)p(e,r,{get:t[r],enumerable:!0})},R=(e,t,r,n)=>{if(t&&typeof t=="object"||typeof t=="function")for(let s of Y(t))!X.call(e,s)&&s!==r&&p(e,s,{get:()=>t[s],enumerable:!(n=Z(t,s))||n.enumerable});return e};var m=(e,t,r)=>(r=e!=null?H(q(e)):{},R(t||!e||!e.__esModule?p(r,"default",{value:e,enumerable:!0}):r,e)),ee=e=>R(p({},"__esModule",{value:!0}),e);var de={};Q(de,{default:()=>fe});module.exports=ee(de);var f=m(require("react")),a=require("@raycast/api");var d=m(require("node:fs")),b=m(require("node:path"));var P=require("react/jsx-runtime");function o(e,t){let r=e instanceof Error?e.message:String(e);return(0,a.showToast)({style:a.Toast.Style.Failure,title:t?.title??"Something went wrong",message:t?.message??r,primaryAction:t?.primaryAction??U(e),secondaryAction:t?.primaryAction?U(e):void 0})}var U=e=>{let t=!0,r="[Extension Name]...",n="";try{let c=JSON.parse((0,d.readFileSync)((0,b.join)(a.environment.assetsPath,"..","package.json"),"utf8"));r=`[${c.title}]...`,n=`https://raycast.com/${c.owner||c.author}/${c.name}`,(!c.owner||c.access==="public")&&(t=!1)}catch{}let s=a.environment.isDevelopment||t,u=e instanceof Error?e?.stack||e?.message||"":String(e);return{title:s?"Copy Logs":"Report Error",onAction(c){c.hide(),s?a.Clipboard.copy(u):(0,a.open)(`https://github.com/raycast/extensions/issues/new?&labels=extension%2Cbug&template=extension_bug_report.yml&title=${encodeURIComponent(r)}&extension-url=${encodeURI(n)}&description=${encodeURIComponent(`#### Error:
\`\`\`
${u}
\`\`\`
`)}`)}}};var l=require("@raycast/api");var i=require("@raycast/api");var g=require("node:child_process"),C=m(require("node:path"));var te={cmux:"com.cmuxterm.app"};function I(e){let t=e?.trim();return t?t.toLowerCase():void 0}function O(e,t){let r=te[t],n=I(t),s=e.find(u=>u.name===t||u.localizedName===t);if(s)return s;if(r){let u=e.find(c=>c.bundleId===r);if(u)return u}if(n)return e.find(u=>[u.name,u.localizedName,u.bundleId].some(c=>I(c)===n))}var re=["cwd","workingDirectory","working_directory"],ne=["focusedCwd","focused_cwd","focusedWorkingDirectory","focused_working_directory"],ae=["focused","active","isFocused","isActive","selected","current"];function _(e){return typeof e=="object"&&e!==null&&!Array.isArray(e)}function D(e,t){for(let r of t){let n=e[r];if(typeof n=="string"&&n.trim())return n}}function E(e){if(Array.isArray(e)){for(let r of e){let n=E(r);if(n)return n}return}if(!_(e))return;let t=D(e,ne);if(t)return t;for(let r of Object.values(e)){let n=E(r);if(n)return n}}function se(e){return ae.some(t=>e[t]===!0)}function T(e){if(Array.isArray(e)){for(let r of e){let n=T(r);if(n)return n}return}if(!_(e))return;let t=D(e,re);if(t)return t;for(let r of Object.values(e)){let n=T(r);if(n)return n}}function A(e){if(Array.isArray(e)){for(let t of e){let r=A(t);if(r)return r}return}if(_(e)){if(se(e)){let t=T(e);if(t)return t}for(let t of Object.values(e)){let r=A(t);if(r)return r}}}function L(e){let t=E(e);if(t)return t;let r=A(e);if(r)return r;throw new Error("cmux did not return a focused workspace with a working directory")}function F(e){return e.includes("Access denied")?"cmux denied external control. In cmux, open Settings -> Automation and set Socket Mode to Allow all local processes or Password.":e.includes("Broken pipe")||e.includes("Failed to write to socket")?"Unable to reach cmux over its automation socket. Make sure cmux is running, then reopen Settings -> Automation and check Socket Mode.":e||"cmux command failed"}function M(e){let n=e.sessions?.find(s=>s.shown)?.tabs?.find(s=>s.shown)?.blocks?.find(s=>s.focused)?.cwd;if(n?.trim())return n;throw new Error("Tern did not report a focused block with a working directory")}async function y(e){if(process.platform!=="darwin")throw new Error("macOS only");let t=process.env.LC_ALL;delete process.env.LC_ALL;let{stdout:r,stderr:n}=(0,g.spawnSync)("osascript",["-e",e]);if(process.env.LC_ALL=t,n?.length)throw new Error(n.toString());return r.toString()}var $=e=>e!=="Clipboard"&&e!=="Finder";async function w(e){let t=await(0,i.getApplications)(),r=O(t,e);if(!r)throw new Error(`${e} not found`);return r}var ie="/System/Library/CoreServices/Finder.app";async function k(e){await(0,i.open)(e,ie)}var oe=1e4;function ce(e){return e.code==="ETIMEDOUT"?new Error("cmux command timed out. In cmux, open Settings -> Automation and set Socket Mode to Allow all local processes or Password."):e}async function h(e){let t=await w("cmux"),r=C.default.join(t.path,"Contents","Resources","bin","cmux"),n=(0,g.spawnSync)(r,e,{encoding:"utf8",timeout:oe}),s=[n.stdout,n.stderr].filter(Boolean).join(`
`).trim();if(n.error)throw ce(n.error);if(n.status!==0)throw new Error(F(s));return n.stdout.trim()}async function W(){let e=await h(["--json","sidebar-state"]),t=JSON.parse(e);return L(t)}var ue=1e4;async function le(e){let t=await w("Tern"),r=C.default.join(t.path,"Contents","MacOS","tern"),n=(0,g.spawnSync)(r,e,{encoding:"utf8",timeout:ue});if(n.error)throw n.error;if(n.status!==0)throw new Error(n.stderr.trim()||"tern command failed");return n.stdout}async function N(){let e=await le(["ls","--json"]);return M(JSON.parse(e))}async function z(e){try{let t=await i.Clipboard.readText()||"",r=await w(e);await(0,i.open)(t,r.path),await(0,i.showToast)(i.Toast.Style.Success,"Done")}catch(t){await o(t)}}async function V(e){let t=`
    if application "${e}" is not running then
      error "${e} is not running"
    end if

    tell application "Finder" to activate
    tell application "${e}" to activate
    tell application "System Events"
      keystroke "open -a Finder ./"
      key code 76
    end tell
  `;try{let r=await y(t);await(0,i.showToast)(i.Toast.Style.Success,"Done",r)}catch(r){await o(r)}}async function j(e){let t=`
    if application "Finder" is not running then
        return "Finder is not running"
    end if

    tell application "Finder"
      if (count of Finder windows) = 0 then error "No Finder window open"
      try
        set pathList to POSIX path of (folder of the front window as alias)
        return pathList
      on error
        error "Could not access Finder window path"
      end try
    end tell
  `;try{let r=await y(t),n=await w(e);await(0,i.open)(r.trim(),n.path),await(0,i.showToast)(i.Toast.Style.Success,"Done")}catch(r){await o(r)}}var B=async()=>{let e=(await l.Clipboard.readText()||"").trim();if(!e){await(0,l.showToast)(l.Toast.Style.Failure,"Clipboard doesn't contain a directory path");return}try{let t=await h([e]);await(0,l.showToast)(l.Toast.Style.Success,"Done",t)}catch(t){await o(t)}};var x=require("@raycast/api");var G=async()=>{try{let e=await W();await k(e),await(0,x.showToast)(x.Toast.Style.Success,"Done")}catch(e){await o(e)}};var v=require("@raycast/api");var K=async()=>{let e=`
      if application "Finder" is not running then
          error "Finder is not running"
      end if

      tell application "Finder"
          if (count of Finder windows) = 0 then error "No Finder window open"
          try
              set pathList to POSIX path of (folder of the front window as alias)
              return pathList
          on error
              error "Could not access Finder window path"
          end try
      end tell
  `;try{let t=(await y(e)).trim(),r=await h([t]);await(0,v.showToast)(v.Toast.Style.Success,"Done",r)}catch(t){await o(t)}};var S=require("@raycast/api");var J=async()=>{try{let e=await N();await k(e),await(0,S.showToast)(S.Toast.Style.Success,"Done")}catch(e){await o(e)}};async function fe(e){let{from:t,to:r}=e.arguments;try{if(t==="Clipboard"&&r==="cmux")await B();else if(t==="Finder"&&r==="cmux")await K();else if(t==="cmux"&&r==="Finder")await G();else if(t==="Tern"&&r==="Finder")await J();else if(t==="Clipboard"&&$(r))await z(r);else if(t==="Finder"&&$(r))await j(r);else if($(t)&&r==="Finder")await V(t);else throw new Error("Invalid combination")}catch(n){await o(n)}}
