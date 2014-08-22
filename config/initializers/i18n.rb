def _(msgid, options = {})
  I18n.translate(msgid, {default: msgid.to_s}.merge(options))
end

I18n.backend = I18n::Backend::Chain.new(I18n::Backend::KeyValue.new(Redis.new, false), I18n.backend)
