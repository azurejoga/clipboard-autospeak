require "import"
import "android.view.*"
import "android.widget.*"
import "com.androlua.*"
function readClipData()
  local ld=LuaDialog(this).setView(loadlayout({EditText,id="master_kaushik"}))
  ld.show()
  local clip = this.getSystemService(this.CLIPBOARD_SERVICE).getPrimaryClip()
  if clip and clip.getItemCount() > 0 then
    local text = clip.getItemAt(0).getText()
    master_kaushik.setText(text)
    ld.hide()
    return master_kaushik.text
   else
    return "No data found!"
  end
end
if tk then
  tk.stop()
  tk = nil
  lastData = nil
  service.postSpeak(500,"ClipDog turned off")
  return true
end
service.postSpeak(500,"ClipDog turned on")
lastData = readClipData()
tk = Ticker()
tk.Period = 1000
tk.onTick = function()
  if lastData ~= readClipData() then
    lastData = readClipData()
    service.postSpeak(500,lastData)
  end
end
tk.start()