def _(msgid, options = {})
  I18n.t(msgid, {default: msgid}.merge(options))
end
