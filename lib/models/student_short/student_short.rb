require_relative '../person/person.rb'

class Student_short < Person
    attr_reader :id, :full_name
    private_class_method :new

    def initialize(full_name:, git:, contact:, id: nil)
        self.id = id
        self.full_name = full_name
        self.git = git
        self.set_contacts(contact)
    end

    # constructor from Student object
    def self.new_from_student_obj(student)
        self.new(
            id: student.id.to_i,
            full_name: student.get_full_name.slice(11..-1),
            git: student.git,
            contact: student.get_any_contact
        )
    end

    # constructor from string
    def self.new_from_string(id, string)
        hash = self.parse_string(string)
        contact = ''
        if hash['telegram'] then
            contact = "telegram: #{hash['telegram']}"
        elsif hash['email']
            contact = "email: #{hash['email']}"
        else 
            contact = "phone_number #{hash['phone_number']}"
        end
        
        self.new(
            id: id.to_i,
            full_name: hash['full_name'],
            git: hash['git'],
            contact: contact
        )
    end

    # checking for contacts availability
    def validate_contacts?
        !(self.get_any_contact.nil? || self.get_any_contact == "")
    end

    # validate git and contacts
    def validate?
        super && self.validate_contacts?
    end

    def get_any_contact
        @contact
    end

    private 
    attr_writer :id

    def set_contacts(contact)
        if contact == 'no contact provided'
            @contact = nil 
            return
        end
        if contact.start_with?('telegram:') then
            telegram = contact.slice(9..-1).strip
            unless self.class.valid_telegram?(telegram)
                raise ArgumentError, "Wrong telegram format"
            end
        elsif contact.start_with?('email:')
            email = contact.slice(6..-1).strip
            unless self.class.valid_email?(email)
                raise ArgumentError, "Wrong email format"
            end
        elsif contact.start_with?('phone_number:')
            phone_number = contact.slice(13..-1).strip
            unless self.class.valid_phone_number?(phone_number)
                raise ArgumentError, "Wrong phone number format"
            end
        else
            raise ArgumentError, "Wrong contact format"
        end
        @contact = contact
    end

    def full_name=(full_name)
        unless self.class.valid_name?(full_name)
            raise ArgumentError, "Wrong name format"
        end
        @full_name = full_name
    end

    # full name validation
    def self.valid_name?(name)
        name =~ /^[А-ЯЁ][а-яё]{1,}(-[А-ЯЁ][а-яё]{1,})?\s[А-ЯЁ].\s?[А-ЯЁ].$/
    end
end