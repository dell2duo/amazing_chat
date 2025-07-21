defmodule AmazingChatWeb.ChatListLive do
  use AmazingChatWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(%{"name" => ""}))}
  end

  def handle_event("create_chat", %{"name" => name}, socket),
    do: {:noreply, redirect(socket, to: "/#{name}")}

  def render(assigns) do
    ~H"""
    <div class="flex flex-col w-full h-full items-center justify-center">
      <div class="w-1/2 max-w-[550px] p-4 space-y-4 mt-6 rounded-2xl shadow-md shadow-gray-800">
        <h2 class="font-semibold text-lg">Welcome to the Amazing Chat ✨</h2>
        <div>
          <p>There's no chats created yet. Let's create the first?</p>
        </div>

        <.form class="space-y-2" for={@form} phx-submit="create_chat">
          <.input field={@form[:name]} placeholder="chat name" required />

          <.button type="submit" class="text-white text-lg px-4 py-2 rounded transition-colors">
            Create Chat
          </.button>
        </.form>
      </div>
    </div>
    """
  end
end
