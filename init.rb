Redmine::Plugin.register :redmine_google_calendarlist do
  name 'Redmine Google Calendarlist plugin'
  author 'So Murota'
  description 'This is a plugin for Redmine'
  version '0.0.1'

  project_module :google_calendarlist do
    permission :view_gcals, :gcals => [:index, :show]
    permission :manage_gcals, :gcals => [:new, :edit, :create, :update, :destroy, :preview],
               :require => :member

    menu :project_menu, :google_calendarlist, { :controller => 'gcals', :action => 'index'}, :param => :project_id


  end

end
