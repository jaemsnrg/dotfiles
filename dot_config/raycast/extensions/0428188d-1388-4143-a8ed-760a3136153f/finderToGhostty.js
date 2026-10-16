"use strict";var x=Object.create;var f=Object.defineProperty;var v=Object.getOwnPropertyDescriptor;var S=Object.getOwnPropertyNames;var E=Object.getPrototypeOf,A=Object.prototype.hasOwnProperty;var T=(e,t)=>{for(var r in t)f(e,r,{get:t[r],enumerable:!0})},p=(e,t,r,a)=>{if(t&&typeof t=="object"||typeof t=="function")for(let o of S(t))!A.call(e,o)&&o!==r&&f(e,o,{get:()=>t[o],enumerable:!(a=v(t,o))||a.enumerable});return e};var h=(e,t,r)=>(r=e!=null?x(E(e)):{},p(t||!e||!e.__esModule?f(r,"default",{value:e,enumerable:!0}):r,e)),_=e=>p(f({},"__esModule",{value:!0}),e);var I={};T(I,{default:()=>P});module.exports=_(I);var c=require("@raycast/api");var u=h(require("react")),n=require("@raycast/api");var l=h(require("node:fs")),d=h(require("node:path"));var b=require("react/jsx-runtime");function g(e,t){let r=e instanceof Error?e.message:String(e);return(0,n.showToast)({style:n.Toast.Style.Failure,title:t?.title??"Something went wrong",message:t?.message??r,primaryAction:t?.primaryAction??m(e),secondaryAction:t?.primaryAction?m(e):void 0})}var m=e=>{let t=!0,r="[Extension Name]...",a="";try{let s=JSON.parse((0,l.readFileSync)((0,d.join)(n.environment.assetsPath,"..","package.json"),"utf8"));r=`[${s.title}]...`,a=`https://raycast.com/${s.owner||s.author}/${s.name}`,(!s.owner||s.access==="public")&&(t=!1)}catch{}let o=n.environment.isDevelopment||t,i=e instanceof Error?e?.stack||e?.message||"":String(e);return{title:o?"Copy Logs":"Report Error",onAction(s){s.hide(),o?n.Clipboard.copy(i):(0,n.open)(`https://github.com/raycast/extensions/issues/new?&labels=extension%2Cbug&template=extension_bug_report.yml&title=${encodeURIComponent(r)}&extension-url=${encodeURI(a)}&description=${encodeURIComponent(`#### Error:
\`\`\`
${i}
\`\`\`
`)}`)}}};var w=require("node:child_process");var R={cmux:"com.cmuxterm.app"};function y(e){let t=e?.trim();return t?t.toLowerCase():void 0}function $(e,t){let r=R[t],a=y(t),o=e.find(i=>i.name===t||i.localizedName===t);if(o)return o;if(r){let i=e.find(s=>s.bundleId===r);if(i)return i}if(a)return e.find(i=>[i.name,i.localizedName,i.bundleId].some(s=>y(s)===a))}async function C(e){if(process.platform!=="darwin")throw new Error("macOS only");let t=process.env.LC_ALL;delete process.env.LC_ALL;let{stdout:r,stderr:a}=(0,w.spawnSync)("osascript",["-e",e]);if(process.env.LC_ALL=t,a?.length)throw new Error(a.toString());return r.toString()}async function U(e){let t=await(0,c.getApplications)(),r=$(t,e);if(!r)throw new Error(`${e} not found`);return r}async function k(e){let t=`
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
  `;try{let r=await C(t),a=await U(e);await(0,c.open)(r.trim(),a.path),await(0,c.showToast)(c.Toast.Style.Success,"Done")}catch(r){await g(r)}}var P=async()=>await k("Ghostty");
