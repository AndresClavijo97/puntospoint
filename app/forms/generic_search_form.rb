#
# Class GenericSearchForm provides a generic form for using it in a search scenario
#
# @author Andres Clavijo andress.clavijo96@gmail.com
#
class GenericSearchForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  #
  # checks if the form is empty
  #
  #
  # @return [ Boolean ]
  #
  def empty?
    attributes.each_key { |attribute| return false if public_send(attribute).present? }
  end
end
