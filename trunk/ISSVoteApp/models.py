#coding: utf8 

from django.db import models
from countries import CountryField
from django.utils.translation import ugettext_lazy as _

# Create your models here.
class Quan(models.Model):
    id_quan = models.CharField(_(u'Mã Quận'),max_length=10, primary_key=True)
    ten_quan = models.CharField(_(u'Tên Quận'),max_length=50)
    
    class Meta:
        db_table = u'quan'
        verbose_name_plural = _(u'Quận')
        
    def __unicode__(self):
        return self.ten_quan
        
class NguoiDan(models.Model):
    id_nguoidan = models.CharField(_(u'Mã người dân'),max_length=10, primary_key=True)
    ho_dem = models.CharField(_(u'Họ và tên đệm'),max_length=50)
    ten = models.CharField(_(u'Tên'),max_length=50)
    ngay_sinh = models.DateField(_(u'Ngày sinh'))
    quoc_tich = CountryField(_(u'Quốc tịch'))
    que_quan = models.CharField(_(u'Quê quán'),max_length=100)
    dia_chi_thuong_tru = models.CharField(_(u'Địa chỉ thường trú'),max_length=100,null=True, blank=True)
    dia_chi_tam_tru = models.CharField(_(u'Địa chỉ tạm trú'),max_length=100,null=True, blank=True)
    thu_an = models.BooleanField(_(u'Trong thời gian thụ án'))
    tam_than = models.BooleanField(_(u'Bệnh tâm thần'))
    id_quan = models.OneToOneField(Quan, verbose_name=_('Quận'))
    
    class Meta:
        db_table = u'nguoi_dan'
        verbose_name_plural = _(u'Người dân')
        
    def __unicode__(self):
        return '%s\t%s\t%s' % (self.nguoidan_id,self.ho_dem,self.ten)
    
class KyBauCu(models.Model):
    id_kybaucu = models.CharField(max_length=10, primary_key=True)
    ten_kybaucu = models.CharField(_(u'Tên Kỳ bầu cử'),max_length=100)
    bat_dau = models.DateTimeField(_(u'Thời gian bắt đầu'))
    ket_thuc = models.DateTimeField(_(u'Thời gian kết thúc'))
    
    class Meta:
        db_table = u'cuoc_bau_cu'
        verbose_name_plural = _(u'Kỳ bầu cử')
    
    def __unicode__(self):
        return self.ten_kybaucu
    
class ToLapDanhSach(models.Model):
    id_kybaucu = models.ForeignKey(KyBauCu,verbose_name=_(u'Kỳ bầu cử'))
    id_nguoilap = models.CharField(_(u'Mã người lập'),max_length=10)
    ho_dem = models.CharField(_(u'Họ và tên đệm'),max_length=50)
    ten = models.CharField(_(u'Tên'),max_length=50)
    
    class Meta:
        db_table = u'to_lap_danh_sach'
        verbose_name_plural =_(u"Tổ lập danh sách")
        unique_together =('id_kybaucu','id_nguoilap')
    
    def __unicode__(self):
        return '%s %s' % (self.ho_dem,self.ten)
        
class ToTheoGioi(models.Model):
    id_kybaucu = models.ForeignKey(KyBauCu,verbose_name=_(u'Kỳ bầu cử'))
    id_nguoitheodoi = models.CharField(_(u'Mã người theo dõi'),max_length=10)
    ho_dem = models.CharField(_(u'Họ và tên đệm'),max_length=50)
    ten = models.CharField(_(u'Tên'),max_length=50)
    
    class Meta:
        db_table = u'to_theo_gioi'
        verbose_name_plural =_(u"Tổ theo dõi")
        unique_together =('id_kybaucu','id_nguoitheodoi')
    
    def __unicode__(self):
        return '%s %s' % (self.ho_dem,self.ten)
    
class ToGiamSat(models.Model):
    id_kybaucu = models.ForeignKey(KyBauCu,verbose_name=_(u'Kỳ bầu cử'))
    id_nguoigiamsat = models.CharField(_(u'Mã người giám sát'),max_length=10)
    ho_dem = models.CharField(_(u'Họ và tên đệm'),max_length=50)
    ten = models.CharField(_(u'Tên'),max_length=50)
    
    class Meta:
        db_table = u'to_giam_sat'
        verbose_name_plural =_(u"Tổ giám sát")
        unique_together =('id_kybaucu','id_nguoigiamsat')
        
    def __unicode__(self):
        return '%s %s' % (self.ho_dem,self.ten)

class DanhSachUngVien(models.Model):
    id_kybaucu = models.ForeignKey(KyBauCu,verbose_name=_(u'Kỳ bầu cử'))
    ung_vien = models.ForeignKey(NguoiDan,verbose_name=_(u'Ứng viên'))

    class Meta:
        db_table = u'danh_sach_ung_vien'
        verbose_name_plural =_(u"Tổ giám sát")
        unique_together =('id_kybaucu','ung_vien')
        
    def __unicode__(self):
        return self.ung_vien
    
class DanhSachCuTri(models.Model):
    id_kybaucu = models.ForeignKey(KyBauCu,verbose_name=_(u'Kỳ bầu cử'))
    nguoi_dan = models.ForeignKey(NguoiDan,verbose_name=_(u'Người dân'))
    bau_cho = models.ForeignKey(DanhSachUngVien,verbose_name=_(u'Bầu cho'))
    
    class Meta:
        db_table = u'danh_sach_cu_tri'
        verbose_name_plural =_(u"Danh sách cử tri")
        unique_together =('id_kybaucu','nguoi_dan')
        
    def __unicode__(self):
        return self.ung_vien
    
    
    
    
    