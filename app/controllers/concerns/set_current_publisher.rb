module SetCurrentPublisher
  extend ActiveSupport::Concern

  included do
    before_action :current_publisher
  end

  private

    def current_publisher
      SynapseContent.configuration.publisher_model.to_s
      # if params[:parish_token]
      #   session[:parish_token] = params[:parish_token]
      # elsif Parish.pluck(:domain).include? Current.domain
      #   session[:parish_token] = Parish.find_by(domain: Current.domain).token
      # # elsif Parish.pluck(:slug).include? Current.subdomain # TODO: Figure out how to listen for subdomains
      # #   session[:parish_token] = Parish.find_by(slug: Current.subdomain).token
      # elsif Parish.pluck(:slug).include? request.subdomain
      #   session[:parish_token] = Parish.find_by(slug: request.subdomain).token
      # end
      #
      # if session[:parish_token]
      #   Current.parish = Parish.find_by(token: session[:parish_token])
      # elsif signed_in?
      #   Current.parish = current_user.parishes_users.first.parish # Do we want this?
      # else
      #   Current.parish = nil
      # end
    end
end
