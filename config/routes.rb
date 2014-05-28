DoorStatusSimple::Application.routes.draw do
  root to: "pages#status"
  get :updates, to: "pages#updates"
end
