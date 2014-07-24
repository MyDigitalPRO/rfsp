require 'spec_helper'

describe RFSP::Fl do

  describe 'projects' do
    let(:projects){RFSP::Fl.parse_rss}
    it 'loads 30 projects from rss' do
      expect(projects.count).to eq 60
    end

    it 'initilize id and uri of projects' do
      expect(projects[0].id.class).to eq Fixnum
      expect(projects[0].uri.class).to eq String
      expect(projects[0].uri).to_not be_empty
      expect(projects[0].id).to be > 0
    end
  end

end
