local M = {}

local plover = "/Applications/Plover.app/Contents/MacOS/Plover"

-- Leader: Cmd+Esc (Esc isn't mapped by Plover, so it gets through)
local LEADER_MODS = { "cmd" }
local LEADER_KEY = "escape"

-- Follow-up keys: unmapped by Plover's default QWERTY layout
local KEYS = {
  toggle = "z",
  suspend = "x",
  resume = "b",
}

local function ploverCmd(cmd)
  hs.task.new(plover, nil, { "-s", "plover_send_command", cmd }):start()
end

function M.start()
  local mode = hs.hotkey.modal.new(LEADER_MODS, LEADER_KEY)

  function mode:entered()
    hs.alert.show("Plover: z toggle / x off / b on", 1)
    self.timer = hs.timer.doAfter(2, function() self:exit() end)
  end

  function mode:exited()
    if self.timer then self.timer:stop() end
  end

  local function run(cmd, msg)
    return function()
      mode:exit()
      ploverCmd(cmd)
      hs.alert.show(msg)
    end
  end

  mode:bind({}, KEYS.toggle, run("toggle", "Plover toggled"))
  mode:bind({}, KEYS.suspend, run("suspend", "Plover off"))
  mode:bind({}, KEYS.resume, run("resume", "Plover on"))
  mode:bind({}, "escape", function() mode:exit() end)
end

return M
