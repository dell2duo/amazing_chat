defmodule AmazingChatWeb.ChatLive do
  require Logger
  alias Ecto.UUID
  use AmazingChatWeb, :live_view

  def mount(%{"room" => room}, _, socket) do
    topic = "topic:#{room}"

    AmazingChatWeb.Endpoint.subscribe(topic)

    {:ok,
     assign(socket,
       topic: topic,
       room_name: room,
       form: to_form(%{"message" => ""}),
       messages: [%{sender: "system", id: UUID.generate(), content: "first message"}]
     )}
  end

  def handle_event("send_message", %{"message" => message}, socket) do
    AmazingChatWeb.Endpoint.broadcast(
      socket.assigns.topic,
      "new_message",
      %{
        message: %{
          sender: "name",
          id: UUID.generate(),
          content: message
        }
      }
    )

    {:noreply, socket}
  end

  def handle_info(%{topic: _topic, event: "new_message", payload: %{message: message}}, socket) do
    Logger.info(message: message)
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [message])}
  end

  def render(assigns) do
    ~H"""
    <div class="flex flex-col items-center justify-between p-4 h-full w-full border">
      <div id="messages">
        <p :for={message <- @messages} id={to_string(message.id)}>
          {message.sender}: {message.content}
        </p>
      </div>
      <.form for={@form} phx-submit="send_message">
        <.input field={@form[:message]} />
      </.form>
    </div>
    """
  end
end
