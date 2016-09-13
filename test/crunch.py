#!/usr/bin/env python
import sys
import os
import glob
import math

#################################################################################
# constants
PRECISION = 6 # decimal places

# keyword dictionary: for the profiling files
kv_time = dict()

kv_time['Exec_time'] = 'Exec_time'

kv_prof = dict()
#PAPI VALUES
kv_prof['PAPI_TOT_INS'] = 'PAPI_TOT_INS'
kv_prof['PAPI_FP_INS'] = 'PAPI_FP_INS'
kv_prof['PAPI_FDV_INS'] = 'PAPI_FDV_INS'
kv_prof['PAPI_VEC_SP'] = 'PAPI_VEC_SP'
kv_prof['PAPI_LD_INS'] = 'PAPI_LD_INS'
kv_prof['PAPI_SR_INS'] = 'PAPI_SR_INS'

kv_prof['PAPI_BR_INS'] = 'PAPI_BR_INS'
kv_prof['PAPI_BR_CN'] = 'PAPI_BR_CN'
kv_prof['PAPI_BR_TKN'] = 'PAPI_BR_TKN'
kv_prof['PAPI_BR_MSP'] = 'PAPI_BR_MSP'
kv_prof['PAPI_BR_PRC'] = 'PAPI_BR_PRC'

kv_prof['PAPI_L2_DCA'] = 'PAPI_L2_DCA'
kv_prof['PAPI_L2_DCM'] = 'PAPI_L2_DCM'
kv_prof['PAPI_L2_TCA']  = 'PAPI_L2_TCA'
kv_prof['PAPI_L2_TCM']  = 'PAPI_L2_TCM'

kv_prof['PAPI_L2_LDM'] = 'PAPI_L2_LDM'
kv_prof['PAPI_L2_STM'] = 'PAPI_L2_STM'

kv_prof['PAPI_L2_DCR'] = 'PAPI_L2_DCR'
kv_prof['PAPI_L2_DCW']  = 'PAPI_L2_DCW'
kv_prof['PAPI_L2_TCR']  = 'PAPI_L2_TCR'
kv_prof['PAPI_L2_TCW'] = 'PAPI_L2_TCW'

kv_prof['PAPI_L3_TCA']  = 'PAPI_L3_TCA'
kv_prof['PAPI_L3_TCM']  = 'PAPI_L3_TCM'
kv_prof['PAPI_L3_DCR']  = 'PAPI_L3_DCR'
kv_prof['PAPI_L3_DCW'] = 'PAPI_L3_DCW'
kv_prof['PAPI_L3_TCR'] = 'PAPI_L3_TCR'
kv_prof['PAPI_L3_TCW'] = 'PAPI_L3_TCW'
kv_prof['PAPI_L3_LDM'] = 'PAPI_L3_LDM'

kv_prof['PAPI_TOT_CYC'] = 'PAPI_TOT_CYC'
kv_prof['PAPI_RES_STL'] = 'PAPI_RES_STL'
kv_prof['PAPI_STL_ICY'] = 'PAPI_STL_ICY'
kv_prof['PAPI_REF_CYC'] = 'PAPI_REF_CYC'
kv_prof['PAPI_FP_OPS'] = 'PAPI_FP_OPS'

#PAPI PERCENTS
kv_prof['FP_INS'] = 'FP_INS'
kv_prof['FDV_INS'] = 'FDV_INS'
kv_prof['VEC_SP'] = 'VEC_SP'
kv_prof['LD_INS'] = 'LD_INS'
kv_prof['SR_INS'] = 'SR_INS'
kv_prof['BR_INS'] = 'BR_INS'
kv_prof['BR_CN'] = 'BR_CN'
kv_prof['BR_TKN'] = 'BR_TKN'
kv_prof['BR_MSP'] = 'BR_MSP'
kv_prof['L2_DCM'] = 'L2_DCM'
kv_prof['L2_LDM'] = 'L2_LDM'
kv_prof['L2_STM'] = 'L2_STM'
kv_prof['L2_DCR'] = 'L2_DCR'
kv_prof['L2_TCM']  = 'L2_TCM'
kv_prof['L2_DCM']  = 'L2_DCM'
kv_prof['L2_DCW']  = 'L2_DCW'
kv_prof['L2_TCR']  = 'L2_TCR'
kv_prof['L2_TCW'] = 'L2_TCW'
kv_prof['L3_TCM']  = 'L3_TCM'
kv_prof['L3_DCR']  = 'L3_DCR'
kv_prof['L3_DCW'] = 'L3_DCW'
kv_prof['L3_TCR'] = 'L3_TCR'
kv_prof['L3_TCW'] = 'L3_TCW'
kv_prof['INS_CYC'] = 'INS_CYC'
kv_prof['STL_ICY'] = 'STL_ICY'
kv_prof['REF_CYC'] = 'REF_CYC'
kv_prof['FPO_CYC'] = 'FPO_CYC'

#GLOBAL MEMORY
kv_prof['gld_requested_throughput'] = 'gld_requested_throughput'
kv_prof['gst_requested_throughput'] = 'gst_requested_throughput'
kv_prof['gld_transactions_per_request'] = 'gld_transactions_per_request'
kv_prof['gst_transactions_per_request'] = 'gst_transactions_per_request'
kv_prof['gld_transactions'] = 'gld_transactions'
kv_prof['gst_transactions'] = 'gst_transactions'
kv_prof['gst_throughput'] = 'gst_throughput'
kv_prof['gld_throughput'] = 'gld_throughput'
kv_prof['nc_cache_global_hit_rate'] = 'nc_cache_global_hit_rate'

#DRAM
kv_prof['dram_write_transactions'] = 'dram_write_transactions'
kv_prof['dram_read_transactions'] = 'dram_read_transactions'
kv_prof['dram_read_throughput'] = 'dram_read_throughput'
kv_prof['dram_write_throughput'] = 'dram_write_throughput'

#L1
kv_prof['l1_cache_global_hit_rate'] = 'l1_cache_global_hit_rate'
kv_prof['l1_cache_local_hit_rate'] = 'l1_cache_local_hit_rate'

#L2
kv_prof['l2_read_throughput'] = 'l2_read_throughput'
kv_prof['l2_write_throughput'] = 'l2_write_throughput'
kv_prof['l2_read_transactions'] = 'l2_read_transactions'
kv_prof['nc_l2_read_transactions'] = 'nc_l2_read_transactions'
kv_prof['l2_write_transactions'] = 'l2_write_transactions'
kv_prof['l2_tex_read_transactions'] = 'l2_tex_read_transactions'
kv_prof['l2_texture_read_hit_rate'] = 'l2_texture_read_hit_rate'
kv_prof['l2_texture_read_throughput'] = 'l2_texture_read_throughput'
#l2_atomic_throughput
#l2_atomic_transactions

#L2_L1
kv_prof['l2_l1_read_hit_rate'] = 'l2_l1_read_hit_rate'
kv_prof['l2_l1_read_throughput'] = 'l2_l1_read_throughput'
kv_prof['l2_l1_write_throughput'] = 'l2_l1_write_throughput'
kv_prof['l2_l1_read_transactions'] = 'l2_l1_read_transactions'
kv_prof['l2_l1_write_transactions'] = 'l2_l1_write_transactions'

#TEXTURE
kv_prof['tex_cache_hit_rate'] = 'tex_cache_hit_rate'
kv_prof['tex_cache_transactions'] = 'tex_cache_transactions'
kv_prof['tex_cache_throughput'] = 'tex_cache_throughput'

#FLOPS
kv_prof['flop_count_sp'] = 'flop_count_sp'
kv_prof['flop_count_sp_add'] = 'flop_count_sp_add'
kv_prof['flop_count_sp_mul'] = 'flop_count_sp_mul'
kv_prof['flop_count_sp_fma'] = 'flop_count_sp_fma'
kv_prof['flop_count_sp_special'] = 'flop_count_sp_special'
#kv_prof['flop_count_dp'] = 'flop_count_dp'
#kv_prof['flop_count_dp_add'] = 'flop_count_dp_add'
#kv_prof['flop_count_dp_mul'] = 'flop_count_dp_mul'
#kv_prof['flop_count_dp_fma'] = 'flop_count_dp_fma'

#FLOPS_QUADRO
kv_prof['flops_sp'] = 'flops_sp'
kv_prof['flops_sp_add'] = 'flops_sp_add'
kv_prof['flops_sp_mul'] = 'flops_sp_mul'
kv_prof['flops_sp_fma'] = 'flops_sp_fma'
kv_prof['flops_dp'] = 'flops_dp'
kv_prof['flops_dp_add'] = 'flops_dp_add'
kv_prof['flops_dp_mul'] = 'flops_dp_mul'
kv_prof['flops_dp_fma'] = 'flops_dp_fma'
kv_prof['flops_sp_special'] = 'flops_sp_special'

#INSTRUCTIONS
kv_prof['inst_executed'] = 'inst_executed'
kv_prof['inst_issued'] = 'inst_issued'
kv_prof['inst_fp_32'] = 'inst_fp_32'
kv_prof['inst_fp_64'] = 'inst_fp_64'
kv_prof['inst_integer'] = 'inst_integer'
kv_prof['inst_bit_convert '] = 'inst_bit_convert '
kv_prof['inst_control'] = 'inst_control'
kv_prof['inst_compute_ld_st'] = 'inst_compute_ld_st'
kv_prof['inst_misc'] = 'inst_misc'
kv_prof['inst_per_warp'] = 'inst_per_warp'
kv_prof['ipc'] = 'ipc'
kv_prof['ipc_instance'] = 'ipc_instance'
kv_prof['issued_ipc'] = 'issued_ipc'
kv_prof['cf_issued'] = 'cf_issued'
kv_prof['cf_executed'] = 'cf_executed'
kv_prof['ldst_issued'] = 'ldst_issued'
kv_prof['ldst_executed'] = 'ldst_executed'
#inst_inter_thread_communication

#STALL
kv_prof['stall_pipe_busy'] = 'stall_pipe_busy'
kv_prof['stall_inst_fetch'] = 'stall_inst_fetch'
kv_prof['stall_exec_dependency'] = 'stall_exec_dependency'
kv_prof['stall_memory_dependency'] = 'stall_memory_dependency'
kv_prof['stall_sync'] = 'stall_sync'
kv_prof['stall_other'] = 'stall_other'
kv_prof['stall_memory_throttle'] = 'stall_memory_throttle'
kv_prof['stall_constant_memory_dependency'] = 'stall_constant_memory_dependency'
kv_prof['stall_not_selected'] = 'stall_not_selected'
kv_prof['stall_texture'] =  'stall_texture'

#STALL_QUADRO
kv_prof['stall_data_request'] = 'stall_data_request'

#EFFICIENCY
kv_prof['sm_efficiency'] = 'sm_efficiency'
kv_prof['sm_efficiency_instance'] = 'sm_efficiency_instance'
kv_prof['warp_execution_efficiency'] = 'warp_execution_efficiency'
kv_prof['flop_sp_efficiency'] = 'flop_sp_efficiency'
kv_prof['flop_dp_efficiency'] = 'flop_dp_efficiency'
kv_prof['warp_nonpred_execution_efficiency'] = 'warp_nonpred_execution_efficiency'
kv_prof['branch_efficiency'] = 'branch_efficiency'
kv_prof['gld_efficiency'] = 'gld_efficiency'
kv_prof['gst_efficiency'] = 'gst_efficiency'
kv_prof['shared_efficiency'] = 'shared_efficiency'
kv_prof['nc_gld_efficiency'] = 'nc_gld_efficiency'

#UTILIZATION
kv_prof['sysmem_utilization'] = 'sysmem_utilization'
kv_prof['ldst_fu_utilization'] = 'ldst_fu_utilization'
kv_prof['alu_fu_utilization'] = 'alu_fu_utilization'
kv_prof['cf_fu_utilization'] = 'cf_fu_utilization'
kv_prof['issue_slot_utilization'] = 'issue_slot_utilization'
kv_prof['l1_shared_utilization'] = 'l1_shared_utilization'
kv_prof['l2_utilization'] = 'l2_utilization'
kv_prof['dram_utilization'] = 'dram_utilization'
kv_prof['tex_utilization'] = 'tex_utilization'
kv_prof['tex_fu_utilization'] = 'tex_fu_utilization'
 
#SYSMEM
kv_prof['sysmem_write_throughput'] = 'sysmem_write_throughput'
kv_prof['sysmem_read_throughput'] = 'sysmem_read_throughput'
kv_prof['sysmem_write_transactions'] = 'sysmem_write_transactions'
kv_prof['sysmem_read_transactions'] = 'sysmem_read_transactions'

#MISC
kv_prof['achieved_occupancy'] = 'achieved_occupancy'
kv_prof['issue_slots'] = 'issue_slots'
kv_prof['eligible_warps_per_cycle'] = 'eligible_warps_per_cycle'
kv_prof['ecc_transactions'] = 'ecc_transactions'
kv_prof['ecc_throughput'] = 'ecc_throughput'
kv_prof['eligible_warps_per_cycle'] = 'eligible_warps_per_cycle'

#EVENTS
kv_prof['tex0_cache_sector_queries'] = 'tex0_cache_sector_queries'
kv_prof['tex1_cache_sector_queries'] = 'tex1_cache_sector_queries'
kv_prof['tex2_cache_sector_queries'] = 'tex2_cache_sector_queries'
kv_prof['tex3_cache_sector_queries'] = 'tex3_cache_sector_queries'
kv_prof['tex0_cache_sector_misses'] = 'tex0_cache_sector_misses'
kv_prof['tex1_cache_sector_misses'] = 'tex1_cache_sector_misses'
kv_prof['tex2_cache_sector_misses'] = 'tex2_cache_sector_misses'
kv_prof['tex3_cache_sector_misses'] = 'tex3_cache_sector_misses'

kv_prof['fb_subp0_read_sectors'] = 'fb_subp0_read_sectors'
kv_prof['fb_subp1_read_sectors'] = 'fb_subp1_read_sectors'
kv_prof['fb_subp0_write_sectors'] = 'fb_subp0_write_sectors'
kv_prof['fb_subp1_write_sectors']= 'fb_subp1_write_sectors'

kv_prof['l2_subp0_write_sector_misses'] = 'l2_subp0_write_sector_misses'
kv_prof['l2_subp1_write_sector_misses'] = 'l2_subp1_write_sector_misses'
kv_prof['l2_subp2_write_sector_misses'] = 'l2_subp2_write_sector_misses'
kv_prof['l2_subp3_write_sector_misses'] = 'l2_subp3_write_sector_misses'
kv_prof['l2_subp0_read_sector_misses']= 'l2_subp0_read_sector_misses'
kv_prof['l2_subp1_read_sector_misses'] = 'l2_subp1_read_sector_misses'
kv_prof['l2_subp2_read_sector_misses'] = 'l2_subp2_read_sector_misses'
kv_prof['l2_subp3_read_sector_misses'] = 'l2_subp3_read_sector_misses'

kv_prof['l2_subp0_write_l1_sector_queries'] = 'l2_subp0_write_l1_sector_queries'
kv_prof['l2_subp1_write_l1_sector_queries'] = 'l2_subp1_write_l1_sector_queries'
kv_prof['l2_subp2_write_l1_sector_queries'] = 'l2_subp2_write_l1_sector_queries'
kv_prof['l2_subp3_write_l1_sector_queries'] = 'l2_subp3_write_l1_sector_queries'
kv_prof['l2_subp0_read_l1_sector_queries'] = 'l2_subp0_read_l1_sector_queries'
kv_prof['l2_subp1_read_l1_sector_queries'] = 'l2_subp1_read_l1_sector_queries'
kv_prof['l2_subp2_read_l1_sector_queries'] = 'l2_subp2_read_l1_sector_queries'
kv_prof['l2_subp3_read_l1_sector_queries'] = 'l2_subp3_read_l1_sector_queries'

kv_prof['l2_subp0_read_l1_hit_sectors'] = 'l2_subp0_read_l1_hit_sectors'
kv_prof['l2_subp1_read_l1_hit_sectors'] = 'l2_subp1_read_l1_hit_sectors'
kv_prof['l2_subp2_read_l1_hit_sectors'] = 'l2_subp2_read_l1_hit_sectors'
kv_prof['l2_subp3_read_l1_hit_sectors'] = 'l2_subp3_read_l1_hit_sectors'

kv_prof['l2_subp0_read_tex_sector_queries'] = 'l2_subp0_read_tex_sector_queries'
kv_prof['l2_subp1_read_tex_sector_queries'] = 'l2_subp1_read_tex_sector_queries'
kv_prof['l2_subp2_read_tex_sector_queries'] = 'l2_subp2_read_tex_sector_queries'
kv_prof['l2_subp3_read_tex_sector_queries'] = 'l2_subp3_read_tex_sector_queries'

kv_prof['l2_subp0_read_tex_hit_sectors'] = 'l2_subp0_read_tex_hit_sectors'
kv_prof['l2_subp1_read_tex_hit_sectors'] = 'l2_subp1_read_tex_hit_sectors'
kv_prof['l2_subp2_read_tex_hit_sectors'] = 'l2_subp2_read_tex_hit_sectors'
kv_prof['l2_subp3_read_tex_hit_sectors'] = 'l2_subp3_read_tex_hit_sectors'

kv_prof['rocache_subp0_gld_thread_count_32b'] =  'rocache_subp0_gld_thread_count_32b'
kv_prof['rocache_subp1_gld_thread_count_32b'] =  'rocache_subp1_gld_thread_count_32b'
kv_prof['rocache_subp2_gld_thread_count_32b'] =  'rocache_subp2_gld_thread_count_32b'
kv_prof['rocache_subp3_gld_thread_count_32b'] =  'rocache_subp3_gld_thread_count_32b'
kv_prof['rocache_subp0_gld_thread_count_64b'] =  'rocache_subp0_gld_thread_count_64b'
kv_prof['rocache_subp1_gld_thread_count_64b'] =  'rocache_subp1_gld_thread_count_64b'
kv_prof['rocache_subp2_gld_thread_count_64b'] =  'rocache_subp2_gld_thread_count_64b'
kv_prof['rocache_subp3_gld_thread_count_64b'] =  'rocache_subp3_gld_thread_count_64b'
kv_prof['rocache_subp0_gld_thread_count_128b'] = 'rocache_subp0_gld_thread_count_128b'
kv_prof['rocache_subp1_gld_thread_count_128b'] =  'rocache_subp1_gld_thread_count_128b'
kv_prof['rocache_subp2_gld_thread_count_128b'] =  'rocache_subp2_gld_thread_count_128b'
kv_prof['rocache_subp3_gld_thread_count_128b'] =  'rocache_subp3_gld_thread_count_128b'

kv_prof['rocache_subp0_gld_warp_count_32b'] =  'rocache_subp0_gld_warp_count_32b'
kv_prof['rocache_subp1_gld_warp_count_32b'] =  'rocache_subp1_gld_warp_count_32b'
kv_prof['rocache_subp2_gld_warp_count_32b'] =  'rocache_subp2_gld_warp_count_32b'
kv_prof['rocache_subp3_gld_warp_count_32b'] =  'rocache_subp3_gld_warp_count_32b'
kv_prof['rocache_subp0_gld_warp_count_64b'] =  'rocache_subp0_gld_warp_count_64b'
kv_prof['rocache_subp1_gld_warp_count_64b'] =  'rocache_subp1_gld_warp_count_64b'
kv_prof['rocache_subp2_gld_warp_count_64b'] =  'rocache_subp2_gld_warp_count_64b'
kv_prof['rocache_subp3_gld_warp_count_64b'] =  'rocache_subp3_gld_warp_count_64b'
kv_prof['rocache_subp0_gld_warp_count_128b'] = 'rocache_subp0_gld_warp_count_128b'
kv_prof['rocache_subp1_gld_warp_count_128b'] =  'rocache_subp1_gld_warp_count_128b'
kv_prof['rocache_subp2_gld_warp_count_128b'] =  'rocache_subp2_gld_warp_count_128b'
kv_prof['rocache_subp3_gld_warp_count_128b'] =  'rocache_subp3_gld_warp_count_128b'

kv_prof['l2_subp0_read_system_sector_queries'] = 'l2_subp0_read_system_sector_queries'
kv_prof['l2_subp1_read_system_sector_queries'] = 'l2_subp1_read_system_sector_queries'
kv_prof['l2_subp2_read_system_sector_queries'] = 'l2_subp2_read_system_sector_queries'
kv_prof['l2_subp3_read_system_sector_queries'] = 'l2_subp3_read_system_sector_queries'
kv_prof['l2_subp0_write_system_sector_queries'] = 'l2_subp0_write_system_sector_queries'
kv_prof['l2_subp1_write_system_sector_queries'] = 'l2_subp1_write_system_sector_queries'
kv_prof['l2_subp2_write_system_sector_queries'] = 'l2_subp2_write_system_sector_queries'
kv_prof['l2_subp3_write_system_sector_queries'] = 'l2_subp3_write_system_sector_queries'

kv_prof['l2_subp0_total_read_sector_queries'] = 'l2_subp0_total_read_sector_queries'
kv_prof['l2_subp1_total_read_sector_queries'] = 'l2_subp1_total_read_sector_queries'
kv_prof['l2_subp2_total_read_sector_queries'] = 'l2_subp2_total_read_sector_queries'
kv_prof['l2_subp3_total_read_sector_queries'] = 'l2_subp3_total_read_sector_queries'
kv_prof['l2_subp0_total_write_sector_queries'] = 'l2_subp0_total_write_sector_queries'
kv_prof['l2_subp1_total_write_sector_queries'] = 'l2_subp1_total_write_sector_queries'
kv_prof['l2_subp2_total_write_sector_queries'] = 'l2_subp2_total_write_sector_queries'
kv_prof['l2_subp3_total_write_sector_queries'] = 'l2_subp3_total_write_sector_queries'

kv_prof['elapsed_cycles_sm'] = 'elapsed_cycles_sm'
kv_prof['gld_inst_8bit'] = 'gld_inst_8bit'
kv_prof['gld_inst_16bit'] = 'gld_inst_16bit'
kv_prof['gld_inst_32bit'] = 'gld_inst_32bit'
kv_prof['gld_inst_64bit'] =  'gld_inst_64bit'
kv_prof['gld_inst_128bit'] =  'gld_inst_128bit'
kv_prof['gst_inst_8bit'] = 'gst_inst_8bit'
kv_prof['gst_inst_16bit'] = 'gst_inst_16bit'
kv_prof['gst_inst_32bit'] = 'gst_inst_32bit'
kv_prof['gst_inst_64bit'] =  'gst_inst_64bit'
kv_prof['gst_inst_128bit'] =  'gst_inst_128bit'
kv_prof['rocache_gld_inst_8bit'] = 'rocache_gld_inst_8bit'
kv_prof['rocache_gld_inst_16bit'] = 'rocache_gld_inst_16bit'
kv_prof['rocache_gld_inst_32bit'] = 'rocache_gld_inst_32bit'
kv_prof['rocache_gld_inst_64bit'] =  'rocache_gld_inst_64bit'
kv_prof['rocache_gld_inst_128bit'] =  'rocache_gld_inst_128bit'
kv_prof['warps_launched'] = 'warps_launched'
kv_prof['threads_launched'] = 'threads_launched'
kv_prof['inst_issued1'] = 'inst_issued1'
kv_prof['inst_issued2'] =  'inst_issued2'
kv_prof['thread_inst_executed'] = 'thread_inst_executed'
kv_prof['gld_request'] = 'gld_request'
kv_prof['gst_request'] = 'gst_request'
kv_prof['active_cycles'] = 'active_cycles'
kv_prof['active_warps'] = 'active_warps'
kv_prof['sm_cta_launched'] = 'sm_cta_launched'
kv_prof['not_predicated_off_thread_inst_executed'] = 'not_predicated_off_thread_inst_executed'
kv_prof['uncached_global_load_transaction'] = 'uncached_global_load_transaction'
kv_prof['global_store_transaction'] = 'global_store_transaction'
kv_prof['__l1_global_load_transactions'] =  'l1_global_load_transactions'
kv_prof['__l1_global_store_transactions'] =  'l1_global_store_transactions'
 
#kv_prof['inst_replay_overhead'] = 'inst_replay_overhead'
#kv_prof['global_cache_replay_overhead'] = 'global_cache_replay_overhead'
#local_load_transactions
#local_store_transactions
#shared_load_transactions
#shared_store_transactions
#local_load_transactions_per_request
#local_store_transactions_per_request
#shared_load_transactions_per_request
#shared_store_transactions_per_request
#local_load_throughput
#local_store_throughput
#shared_load_throughput
#shared_store_throughput
#shared_efficiency
#shared_replay_overhead
#global_cache_replay_overhead
#local_replay_overhead
#local_memory_overhead
#atomic_replay_overhead
#atomic_transactions
#atomic_transactions_per_request
#inst_replay_overhead
#global_cache_replay_overhead
#shared_replay_overhead
#local_memory_overhead
#l2_atomic_throughput
#l2_tex_read_transactions
#l2_atomic_transactions
#atomic_throughput

# fixed header fields for synthetic
#fixed_header = ['app','input','ite','pct_gpu','blk_gpu','thrd_cpu','mask_type','mask_radius','numAdd','numMult']

# fixed header fields for apps
fixed_header = ['app','api','input','ite','thrd_cpu']

HEADER_FIXED_COLS = len(fixed_header)

# append variables to the header
#header.append('proctime')
# metrics contains the sorted list of metrics
header = list()

metrics_time = list()
for metric in kv_time:
  metrics_time.append(metric)
#  header.append(kv_time[metric])

metrics_prof = list()
for metric in kv_prof:
  metrics_prof.append(metric)
  header.append(kv_prof[metric])

#sort the header by metric name
header.sort()
metrics_time.sort()
metrics_prof.sort()

#Exec_time will be the first metric after the fixed header
header.insert(0,'Exec_time')

header = fixed_header + header

###############################################################################
# utils
def help():
  print 'Uses:'
  print ' ', sys.argv[0], 'for help.'
  print ' ', sys.argv[0], 'directory with results\n'
        
  print 'Metrics:'
  for metric in metrics:
    print ' ', metric

# walks the test directory and reads the profiling and time directories.
# the list returns two rows containing file names.
def get_test_files():
  if len(sys.argv) != 2:
    help()
    sys.exit(1)
  
  basedir = sys.argv[1]
  prof = basedir + '/prof'
  time = basedir + '/time'

  for d in (basedir, prof):
    if not os.path.isdir(d):
      print 'Error: ' + dirname + ' is not a directory.\n'
      sys.exit(1)

  return (glob.glob(prof+'/*'), glob.glob(time+'/*'))

################################################################################
# extracts attributes from a file name
def get_attr_from_filename(fname):
  a = fname.split('/')[-1].split('_')
  a[-1] = a[-1].split('.')[0]
  return a

# gets metric from file by name
def extract_values(metric, fname):
  rawfile = open(fname, 'r')
  val = list()

  for line in rawfile:
    #if line.find(metric) >= 0:
    if metric in line.split( ):
      #raw_value = line.split()[-1].replace('#','').replace('%','')
      raw_value = line.split()[-1].replace('#','').replace('%','').replace('GB/s','').replace('MB/s','').replace('KB/s','').replace('B/s','').replace('Low','').replace('High','').replace('Idle','').replace('(','').replace(')','')
      val.append(float(raw_value)) # enqueue the value

  if len(val) == 0:
    return [ 'NA' ]
  else:
    return val

def list_as_csv(x):
  return ','.join(map(str, x))

def mean(data, ignore=False):
  # do not ignore 'NA' => if present, the result is 'NA'
  if ignore == False:
    if 'NA' in data:
      return 'NA'
    return round(sum(data)/float(len(data)), PRECISION)

  # ignore 'NA' => consider only the non 'NA' values
  else:
    summ = n = 0.0
    for i in range(len(data)):
      if data[i] != 'NA':
        n += 1.0
        summ += data[i]
    return round(summ / n, PRECISION)
        

def std(data, ignore=False):
  # do not ignore 'NA' => if present, the result is 'NA'
  if ignore == False:
    if 'NA' in data:
      return 'NA'
    m = mean(data)
    b = tuple((x-m)*(x-m) for x in data)
    return round(math.sqrt(sum(b)/float(len(b))), PRECISION)

  # ignore 'NA' => consider only the non 'NA' values
  else:
    m = mean(data,True)
    summ = n = 0.0
    for i in range(len(data)):    
      if data[i] != 'NA':
        n += 1.0
        summ += (data[i]-m)*(data[i]-m)
    return round(math.sqrt(summ/n), PRECISION)

def get_column(matrix,col):
  return list(row[col] for row in matrix)

def set_column(matrix, col, values):
  if len(matrix) != len(values):
    print 'Error: different dimensions in set_column ' +\
          str(len(matrix)) + ' ' + str(len(values))
    sys.exit()

  for row in range(len(matrix)):
    matrix[row][col] = values[row]

def zscore(value, m, s):
  if value != 'NA':
    return round((value-m)/s, PRECISION)

###############################################################################
# main 
files = get_test_files()
prof_files = files[0]
time_files = files[1]

time_files.sort()
prof_files.sort()

#if len(prof_files) != len(time_files):
#  print 'Error: number of files differ in the "prof" and "time" directories'
#  sys.exit()

# extract the results from the files
results = list()
for i in range(len(time_files)):
  # extract configuration attributes from the file name
  data = get_attr_from_filename(time_files[i])

  # from the "time" files, we want PS: also needs to take this for prof
  for metric in metrics_time:
    data += [ mean(extract_values(metric, time_files[i])) ]

  # for the "prof" files, we want all metrics
  #if data[3] > '0' :
#  for metric in metrics_prof:
#  	data += [ mean(extract_values(metric, prof_files[i])) ]
  #k += 1
	
  # create a results row
  results.append(data)

# sort the results 
#results.sort()

# compute the mean and stddev for the results
#beg = HEADER_FIXED_COLS
#end = len(results[0])
#meanrow = list('mean' for i in range(beg))
#stdrow = list('std' for i in range(beg))

#for i in range(beg, end):
  #column = get_column(results,i)
  #m = mean(column, True) # True = ignore 'NA's
  #s = std(column, True)
  #meanrow.append(m)
  #stdrow.append(s)

  # compute zscores (only for non-'NA' values)
  #for row in range(len(results)):
  #  if results[row][i] != 'NA':
  #    if s == 0.0:
  #     s = 1.0
      #results[row][i] = round((results[row][i]-m)/float(s), PRECISION)

#results.append(meanrow)
#results.append(stdrow)

print list_as_csv(header)
for r in results:
  print list_as_csv(r)
