import os


def create_key(template, outtype=('nii.gz',), annotation_classes=None):
    if template is None or not template:
        raise ValueError('Template must be a valid format string')
    return template, outtype, annotation_classes


def infotodict(seqinfo):
    """Heuristic evaluator for determining which runs belong where

    allowed template fields - follow python string module:

    item: index within category
    subject: participant id
    seqitem: run number during scanning
    subindex: sub index within group
    """
    # t1w_low_res = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_acq-lowres_t1w')
    t1w_high_res = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_acq-highres_t1w')
    # t2w = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_dark-fluid_t2w')
    # epi = create_key('sub-{subject}/{session}/anat/sub-{subject}_{session}_epi')
    dwi = create_key('sub-{subject}/{session}/dwi/sub-{subject}_{session}_dwi')
    rest = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_bold')
    # rest_ss = create_key('sub-{subject}/{session}/func/sub-{subject}_{session}_task-rest_single_shot')
    # not_used = create_key('sub-{subject}/{session}/no-used/sub-{subject}_{session}_no-used')
    info = {rest: [],
            dwi: [],
            # t1w_low_res: [],

            # t2w: [],
            # rest_ss: [],
            # not_used: [],
            t1w_high_res: []
            }

    for s in seqinfo:
        """
        The namedtuple `s` contains the following fields:

        * total_files_till_now
        * example_dcm_file
        * series_id
        * dcm_dir_name
        * unspecified2
        * unspecified3
        * dim1
        * dim2
        * dim3
        * dim4
        * TR
        * TE
        * protocol_name
        * is_motion_corrected
        * is_derived
        * patient_id
        * study_description
        * referring_physician_name
        * series_description
        * image_type
        """
        if ("mprage_wip542d_A-P_version-cita" in s.series_id) and (s.dim4 == 1):
            info[t1w_high_res] = [s.series_id]
        elif "ep2d_rest state" in s.series_id and s.dim4 > 50 and s.TR == 1.94:
            info[rest] = [s.series_id]
        # elif s.protocol_name == "mp2rage_p3_A-P_version-cita":
        #     info[t1w_low_res] = [s.series_id]
        # elif s.protocol_name == "t2_tirm_tra_dark-fluid_3mm":
        #     info[t2w] = [s.series_id]
        elif "dif" in s.series_id and s.series_description == "ep2d_diff_mddw_20_76slices_p2":
             info[dwi] = [s.series_id]
        # elif s.protocol_name == "low resolution single shot whole brain":
        #     info[rest_ss] = [s.series_id]
        # elif s.protocol_name == "gre_field_mapping_EPI":
        #     info[epi] = [s.series_id]

    return info