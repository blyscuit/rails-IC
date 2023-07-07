# frozen_string_literal: true

module OAuthFake
  def self.google
    {
      provider: 'google_oauth2',
      uid: '123456789',
      info: {
        name: 'John Doe',
        email: 'john.doe@example.com',
        first_name: 'John',
        last_name: 'Doe',
        image: 'https://lh3.googleusercontent.com/url/photo.jpg'
      },
      credentials: {
        token: 'token',
        refresh_token: 'another_token',
        expires_at: 1_354_920_555,
        expires: true
      },
      extra: {
        raw_info: {
          sub: '123456789',
          email: 'john.doe@example.com',
          email_verified: true,
          name: 'John Doe',
          given_name: 'John',
          family_name: 'Doe',
          profile: 'https://plus.google.com/123456789',
          picture: 'https://lh3.googleusercontent.com/url/photo.jpg',
          gender: 'male',
          birthday: '0000-06-25',
          locale: 'en',
          hd: 'example.com'
        },
        id_info: {
          'iss' => 'accounts.google.com',
          'at_hash' => 'HK6E_P6Dh8Y93mRNtsDB1Q',
          'email_verified' => 'true',
          'sub' => '10769150350006150715113082367',
          'azp' => 'APP_ID',
          'email' => 'jsmith@example.com',
          'aud' => 'APP_ID',
          'iat' => 1_353_601_026,
          'exp' => 1_353_604_926,
          'openid_id' => 'https://www.google.com/accounts/o8/id?id=ABCdfdswawerSDFDsfdsfdfjdsf'
        }
      }
    }
  end
end
