# frozen_string_literal: true

class Hotfile
  ## Metaclass for loading all parser modules
  class Record
    require 'hotfile/record/record'
    require 'hotfile/record/BAR64'
    require 'hotfile/record/BAR65'
    require 'hotfile/record/BAR66'
    require 'hotfile/record/BAR67'
    require 'hotfile/record/BCC82'
    require 'hotfile/record/BCX83'
    require 'hotfile/record/BCH02'
    require 'hotfile/record/BCT95'
    require 'hotfile/record/BFH01'
    require 'hotfile/record/BFT99'
    require 'hotfile/record/BKF81'
    require 'hotfile/record/BKI61'
    require 'hotfile/record/BKI62'
    require 'hotfile/record/BKI63'
    require 'hotfile/record/BKP84'
    require 'hotfile/record/BKS24'
    require 'hotfile/record/BKS30'
    require 'hotfile/record/BKS31'
    require 'hotfile/record/BKS39'
    require 'hotfile/record/BKS42'
    require 'hotfile/record/BKS45'
    require 'hotfile/record/BKS46'
    require 'hotfile/record/BKS47'
    require 'hotfile/record/BKT06'
    require 'hotfile/record/BOH03'
    require 'hotfile/record/BOT93'
    require 'hotfile/record/BOT94'
  end
end
