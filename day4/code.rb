class Passport
  attr_reader :data

  FIELDS = {
    'byr' => 'Birth Year',
    'iyr' => 'Issue Year',
    'eyr' => 'Expiration Year',
    'hgt' => 'Height',
    'hcl' => 'Hair Color',
    'ecl' => 'Eye Color',
    'pid' => 'Passport ID',
    'cid' => 'Country ID'
  }.freeze

  def initialize(data)
    @data = hashify(data)
  end

  def valid?
    present_values? && valid_values?
  end

  def present_values?
    ((FIELDS.keys - @data.keys) - ['cid']).empty?
  end

  def valid_values?
    @data.all? do |k, v|
      send("validate_#{k}", v)
    end
  end

  def validate_byr(byr)
    (1920..2002).cover?(byr.to_i)
  end

  def validate_iyr(iyr)
    (2010..2020).cover?(iyr.to_i)
  end

  def validate_eyr(eyr)
    (2020..2030).cover?(eyr.to_i)
  end

  def validate_hgt(hgt)
    int = hgt.delete("^0-9").to_i
    if hgt.match(/cm$/)
      (150..193).cover?(int)
    elsif hgt.match(/in$/)
      (59..76).cover?(int)
    else
      false
    end
  end

  def validate_hcl(hcl)
    hcl.match(/^#[0-9a-f]{6}/)
  end

  def validate_ecl(ecl)
    %w(amb blu brn gry grn hzl oth).include?(ecl)
  end

  def validate_pid(pid)
    pid.match(/^[0-9]{9}$/)
  end

  def validate_cid(cid)
    true
  end

  def hashify(data)
    data.split("\s").map { |cred| cred.split(':') }.to_h
  end
end

passports = File.read('input.txt').split("\n\n").map do |data|
  Passport.new(data)
end

puts passports.select(&:valid?).count
