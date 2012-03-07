#JsonSerializable
In my projects I have found the basic as_json method that you get from Rails to be quite limiting. For example, as_json takes :methods, but the hash key can only be the method's name. Similar restriction applies to the :only option. So, I am extending this method in JsonSerializable so that you can customize your JSON output with a simple declarative syntax.

## Build Status
[![Build Status](https://secure.travis-ci.org/smsohan/json_serializer.png)](http://travis-ci.org/smsohan/json_serializer)


##In you Gemfile:

    gem :json_serializable


##Or install directly:

    gem install json_serializable


##In your model:

    class Content
      include JsonSerializable

      json_serializable [:name, :description], private: lambda {|content| content.secret_data.upcase}, :street => :address

      def street
        "#{street_number} #{street_name}"
      end

    end

##If your model has the following data:

    calgaryNews = Content.new(name: 'Sunny', description: 'Awesome sunny and bright day', secret_data: 'ggh98',
                              street_number: 2301, street_number: 'Varsity DR NW')


##JsonSerializable will produce the following Hash for your json:

    calgaryNews.as_json
    #==>
    {
      name: 'Sunny', description: 'Awesome sunny and bright day', private: 'GGH98',
                                address: "2301 Varsity DR NW'
    }

Released under DWTFYW (Do What the F* You Want) License.