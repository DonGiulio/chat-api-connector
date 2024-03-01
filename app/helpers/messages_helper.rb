# frozen_string_literal: true

module MessagesHelper
  def message_css_class(message)
    classes = ['message-bubble']
    classes << (message.role == 'assistant' ? 'assistant-message' : 'user-message')
    classes << (message.profile.gender == 'female' ? 'female' : 'male')
    classes.join(' ')
  end
end
