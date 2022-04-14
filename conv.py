import configparser as cp
import numpy as np
import sys

from ROOT import TFile, TH1D

if __name__ == "__main__":

    if (len(sys.argv)==3):

        filenameNpz = str(sys.argv[1])
        filenameRoot = str(sys.argv[2])
        
        cher_ph = np.load(filenameNpz)
        
        #shower_prop        <class 'numpy.ndarray'>   (3,)
        #
        #wavelengths        <class 'numpy.ndarray'>   (100,)
        #wavelength_counts  <class 'numpy.ndarray'>   (99,)
        #
        #dist_bins          <class 'numpy.ndarray'>   (100,)
        #dist_counts        <class 'numpy.ndarray'>   (99,)
        #
        #time_bins          <class 'numpy.ndarray'>   (200,)
        #time_counts        <class 'numpy.ndarray'>   (99, 199)
        #time_offset        <class 'numpy.ndarray'>   (99,)
        #
        #angle_bins         <class 'numpy.ndarray'>   (200,)
        #angle_counts       <class 'numpy.ndarray'>   (99, 199)
        #angle_offset       <class 'numpy.ndarray'>   (99,)
        
        #create_root_file
        file = TFile(filenameRoot, 'recreate')
        
        # define histograms
        histo_shower_prop = TH1D()
        histo_w = TH1D()
        histo_r = TH1D()
        histo_t_off = TH1D()
        histo_ang_off = TH1D()
        
        
        num_wl_bin = len(cher_ph["wavelengths"]) - 1
        num_dist_bin = len(cher_ph["dist_bins"]) - 1
        num_time_bin = len(cher_ph["time_bins"]) - 1
        num_ang_bin = len(cher_ph["angle_bins"]) - 1
        
        # define histograms
        histo_shower_prop = TH1D("histo_shower_prop", "histo_shower_prop", 3, -0.5,2.5)
        histo_w = TH1D("wl", "wavelength", num_wl_bin, cher_ph["wavelengths"])
        histo_r = TH1D("r", "distance", num_dist_bin, cher_ph["dist_bins"])
        histo_t_off = TH1D("t_off", "time offset", num_dist_bin, cher_ph["dist_bins"])
        histo_ang_off = TH1D("ang_off", "angle offset", num_dist_bin, cher_ph["dist_bins"])
        histo_t = [TH1D("t_dist_" + str(i), "time_dist_" + str(i),
                        num_time_bin, cher_ph["time_bins"]) for i in range(num_dist_bin)]
        histo_ang = [TH1D("ang_dist_" + str(i), "angle_dist_" + str(i),
                          num_ang_bin, cher_ph["angle_bins"]) for i in range(num_dist_bin)]
        
        histo_shower_prop.SetBinContent(1, cher_ph["shower_prop"][0])
        histo_shower_prop.SetBinContent(2, cher_ph["shower_prop"][1])
        histo_shower_prop.SetBinContent(3, cher_ph["shower_prop"][2])
        
        # fill histograms
        for wl_bin, counts in enumerate(cher_ph["wavelength_counts"]):
            histo_w.SetBinContent(wl_bin + 1, counts)
            for r_bin, counts in enumerate(cher_ph["dist_counts"]):
                histo_r.SetBinContent(r_bin + 1, counts)
                histo_t_off.SetBinContent(r_bin + 1, cher_ph["time_offset"][r_bin])
                histo_ang_off.SetBinContent(r_bin + 1, cher_ph["angle_offset"][r_bin])
                for t_bin, counts_t in enumerate(cher_ph["time_counts"][r_bin]):
                    histo_t[r_bin].SetBinContent(t_bin + 1, counts_t)
                for ang_bin, counts_ang in enumerate(cher_ph["angle_counts"][r_bin]):
                    histo_ang[r_bin].SetBinContent(ang_bin + 1, counts_ang)
                        
        for i in range(num_dist_bin):
            histo_t[i].Write();
            histo_ang[i].Write();
            
        histo_shower_prop.Write()
        histo_w.Write()
        histo_r.Write()
        histo_t_off.Write()
        histo_ang_off.Write()
        
        file.Close()

    else:
        print(' --> ERROR in input arguments') 
        print('     [1] - input npz file ')
        print('     [2] - output root file ')
