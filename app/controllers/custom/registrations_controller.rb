class Custom::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    super do |resource|

        doctor = Doctor.new
        doctor.save

        user = User.find(resource.id)

        user.owner_id = doctor.id
        user.owner_type = "Doctor"

        user.save
      end
  end

  def update
    super do |resource|
      puts "==========update user==========="
      puts resource.to_json
    end
  end
end
