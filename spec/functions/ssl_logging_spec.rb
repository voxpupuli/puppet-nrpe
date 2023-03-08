# frozen_string_literal: true

require 'spec_helper'

describe 'nrpe::ssl_logging' do
  context 'all logging options set to true' do
    it 'returns the string \'0x3f\' (63 formatted as a 2 digit hex string)' do
      is_expected.to run.with_params(true, true, true, true, true, true).and_return('0x3f')
    end
  end

  context 'all logging options set to false' do
    it 'returns the string \'0x00\'' do
      is_expected.to run.with_params(false, false, false, false, false, false).and_return('0x00')
    end
  end
end
