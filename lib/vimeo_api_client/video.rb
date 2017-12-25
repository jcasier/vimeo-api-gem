require 'vimeo_api_client/has_children'

module Vimeo
  class Video < Resource

    include Client
    include HasChildren

    has_many :text_tracks
    has_many :thumbnails

    # def initialize(uri = nil, parents = {})
    #   @id = strip_to_id(uri)
    #   @parents = parents
    # end

    def show
      get("/videos/#{@id}")
    end

    def update(options = {})
      patch("/videos/#{@id}", options)
    end

    def update_timeline_events(options)
      patch("/videos/#{@id}/timelineevents", options)
    end

    def destroy
      delete("/videos/#{@id}")
    end

    def create_by_pulling(link)
      post('/me/videos', type: 'pull', link: link)
    end

    def update_by_pulling(link)
      put("/videos/#{@id}/files", type: 'pull', link: link)
    end

    def generate_upload_ticket(redirect_url)
      post('/me/videos', type: 'post', redirect_url: redirect_url)
    end

    def create_as_resumable
      post('/me/videos', type: 'streaming')
    end

    def upload_as_resumable(upload_link, file)
      put(upload_link, file)
    end

  end
end
