def _(msgid, options = {})
  I18n.t(msgid, {default: msgid.to_s}.merge(options))
end
