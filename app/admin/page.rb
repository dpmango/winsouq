ActiveAdmin.register Page do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :content
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :title
      f.input :content, :input_html => { :class => "tinymce" }
    end
    f.actions do
      f.action :submit
      f.action :cancel
      # f.submit, as: :button, label: 'Save'
      # f.cancel, as: :link # I think could converted to button as submit
      # link_to 'Preview', preview_my_admin_panel_posts_path(@post)
    end
  end

end
